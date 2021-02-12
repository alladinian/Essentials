//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 7/2/21.
//

import Foundation
import CoreData


func &&(left: NSPredicate?, right: NSPredicate?) -> NSCompoundPredicate {
    NSCompoundPredicate(andPredicateWithSubpredicates: [left, right].compactMap({$0}))
}

func ||(left: NSPredicate, right: NSPredicate) -> NSCompoundPredicate {
    NSCompoundPredicate(orPredicateWithSubpredicates: [left, right])
}

func ==(left: String, flag: Bool) -> NSPredicate {
    NSPredicate(format: "%K == %@", left, NSNumber(booleanLiteral: flag))
}

func ==(left: String, object: NSObject) -> NSPredicate {
    NSPredicate(format: "%K == %@", left, object)
}

func ~=(left: String, right: NSObject) -> NSPredicate {
    NSPredicate(format: "ANY %K == %@", left, right)
}

func ===(left: NSManagedObject, right: String) -> NSPredicate {
    NSPredicate(format: "%@ IN %K", left, right)
}

public extension NSManagedObject {

    func `in`(_ collectionPath: String) -> NSPredicate {
        NSPredicate(format: "%@ IN %K", self, collectionPath)
    }

}

public extension String {

    func anyIs(_ object: NSObject) -> NSPredicate {
        NSPredicate(format: "ANY %K == %@", self, object)
    }

    func `is`(_ object: NSObject) -> NSPredicate {
        NSPredicate(format: "%K == %@", self, object)
    }

    func `is`(_ text: String) -> NSPredicate {
        NSPredicate(format: "%K == %@", self, text)
    }

    func `is`(_ flag: Bool) -> NSPredicate {
        NSPredicate(format: "%K == %@", self, NSNumber(booleanLiteral: flag))
    }

    func contains(_ text: String) -> NSPredicate {
        NSPredicate(format: "%K contains[cd] %@", self, text)
    }

}

public extension Array where Element == NSPredicate {
    var orJoined: NSCompoundPredicate {
        NSCompoundPredicate(orPredicateWithSubpredicates: self)
    }

    var andJoined: NSCompoundPredicate {
        NSCompoundPredicate(andPredicateWithSubpredicates: self)
    }
}


// MARK: - typed predicate types
public protocol TypedPredicateProtocol: NSPredicate { associatedtype Root }

public final class CompoundPredicate<Root>: NSCompoundPredicate, TypedPredicateProtocol {}

public final class ComparisonPredicate<Root>: NSComparisonPredicate, TypedPredicateProtocol {}

// MARK: - compound operators
public func && <TP: TypedPredicateProtocol>(p1: TP, p2: TP) -> CompoundPredicate<TP.Root> {
    CompoundPredicate(type: .and, subpredicates: [p1, p2])
}

public func || <TP: TypedPredicateProtocol>(p1: TP, p2: TP) -> CompoundPredicate<TP.Root> {
    CompoundPredicate(type: .or, subpredicates: [p1, p2])
}

public prefix func ! <TP: TypedPredicateProtocol>(p: TP) -> CompoundPredicate<TP.Root> {
    CompoundPredicate(type: .not, subpredicates: [p])
}

// MARK: - comparison operators
public func == <E: Equatable, R, K: KeyPath<R, E>>(keyPath: K, value: E) -> ComparisonPredicate<R> {
    ComparisonPredicate(keyPath, .equalTo, value)
}

public func != <E: Equatable, R, K: KeyPath<R, E>>(keyPath: K, value: E) -> ComparisonPredicate<R> {
    ComparisonPredicate(keyPath, .notEqualTo, value)
}

public func > <C: Comparable, R, K: KeyPath<R, C>>(keyPath: K, value: C) -> ComparisonPredicate<R> {
    ComparisonPredicate(keyPath, .greaterThan, value)
}

public func < <C: Comparable, R, K: KeyPath<R, C>>(keyPath: K, value: C) -> ComparisonPredicate<R> {
    ComparisonPredicate(keyPath, .lessThan, value)
}

public func <= <C: Comparable, R, K: KeyPath<R, C>>(keyPath: K, value: C) -> ComparisonPredicate<R> {
    ComparisonPredicate(keyPath, .lessThanOrEqualTo, value)
}

public func >= <C: Comparable, R, K: KeyPath<R, C>>(keyPath: K, value: C) -> ComparisonPredicate<R> {
    ComparisonPredicate(keyPath, .greaterThanOrEqualTo, value)
}

public func === <S: Sequence, R, K: KeyPath<R, S.Element>>(keyPath: K, values: S) -> ComparisonPredicate<R> where S.Element: Equatable {
    ComparisonPredicate(keyPath, .in, values)
}

// MARK: - internal
extension ComparisonPredicate {
    convenience init<VAL>(_ keyPath: KeyPath<Root, VAL>, _ op: NSComparisonPredicate.Operator, _ value: Any?) {
        let ex1 = \Root.self == keyPath ? NSExpression.expressionForEvaluatedObject() : NSExpression(forKeyPath: keyPath)
        let ex2 = NSExpression(forConstantValue: value)
        self.init(leftExpression: ex1, rightExpression: ex2, modifier: .direct, type: op)
    }
}

//MARK: - Misc

public extension NSCompoundPredicate {

    /// Convenience initializer for a compound predicate from a generic dictionary
    ///
    /// - Parameter params: The params dictionary where each key must match the respective value in the predicate
    convenience init(params: [String : Any]) {
        var predicates = [NSPredicate]()
        for (param, value) in params {
            predicates.append(NSPredicate(format: "%K == %@", argumentArray: [param, value]))
        }
        self.init(andPredicateWithSubpredicates: predicates)
    }

}

//MARK: - NSFetchedResultsController

extension NSManagedObjectContext {

    func fetchController<T: NSFetchRequestResult>(entityName: String = "\(T.self)", predicate: NSPredicate? = nil, sortedOn sortFields: [String]? = nil, sectionKey: String? = nil) -> NSFetchedResultsController<T> {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        if let fields = sortFields {
            fetchRequest.sortDescriptors = fields.map { NSSortDescriptor.ascendingFor($0) }
        }
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: self,
                                                    sectionNameKeyPath: sectionKey,
                                                    cacheName: nil)
        return controller
    }

}

//MARK: - NSManagedObject

public extension NSFetchRequestResult where Self : NSManagedObject {

    static var entityName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }

    @discardableResult
    static func create(_ context: NSManagedObjectContext, params: [String : Any]? = nil) -> Self {
        let object = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: context) as! Self
        return object.update(context, params: params)
    }

    @discardableResult
    func update(_ context: NSManagedObjectContext, params: [String : Any]? = nil) -> Self {

        guard let params = params else {
            return self
        }

        for (key, value) in params where entity.attributesByName.keys.contains(key) == true {
            self.willChangeValue(forKey: key)
            self.setValue(value, forKey: key)
            self.didChangeValue(forKey: key)
        }

        return self
    }

    static func all(context: NSManagedObjectContext, includeProperties: Bool = true) -> [Self] {
        return find(nil, context: context, includeProperties: includeProperties)
    }

    static func count(context: NSManagedObjectContext, predicate: NSPredicate? = nil) -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        fetchRequest.predicate = predicate
        return (try? context.count(for: fetchRequest)) ?? 0
    }

    static func find(_ predicate: NSPredicate?, context: NSManagedObjectContext, includeProperties: Bool = true) -> [Self] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        fetchRequest.predicate = predicate
        fetchRequest.includesPropertyValues = includeProperties
        let matches = try? context.fetch(fetchRequest) as? [Self]
        return matches ?? []
    }

    static func firstWithID(_ id: String, context: NSManagedObjectContext, includeProperties: Bool = true) -> Self? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        fetchRequest.includesPropertyValues = includeProperties
        let match = find(predicate, context: context)
        return match.first
    }

    @discardableResult
    static func findOrCreate(id: String, params: [String : Any], context: NSManagedObjectContext) -> Self {
        if let item = firstWithID(id, context: context) {
            return item
        }
        return create(context, params: params)
    }

    @discardableResult
    static func createOrUpdate(id: String, params: [String : Any], context: NSManagedObjectContext) -> Self {
        if let item = firstWithID(id, context: context) {
            return item.update(context, params: params)
        }
        return create(context, params: params)
    }

    func safeForUse(context: NSManagedObjectContext?) -> Bool {
        guard let _ = managedObjectContext, let context = context, !isDeleted else {
            return false
        }

        do {
            _ = try context.existingObject(with: objectID)
        } catch {
            debugPrint(error)
            return false
        }
        return true
    }

}
