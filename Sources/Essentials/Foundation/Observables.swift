//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

import Foundation

public protocol Observable {
    var name: String { get }
}

public extension Observable {

    func post(error: Error? = nil, associatedObject: Any? = nil) {
        var userInfo: [AnyHashable : Any] = [:]
        if let error = error {
            userInfo["error"] = error
        }
        if let object = associatedObject {
            userInfo["associatedObject"] = object
        }
        let notificationName = Foundation.Notification.Name(rawValue: name)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: userInfo)
    }

}

public extension NSObject {

    @discardableResult
    func observe(_ notification: Foundation.Notification.Name, usingBlock block: @escaping ((Foundation.Notification) -> Void)) -> NSObjectProtocol {
        NotificationCenter.default.addObserver(forName: notification,
                                               object: nil,
                                               queue: OperationQueue.main,
                                               using: block)
    }

    @discardableResult
    func observe(_ observable: Observable, usingBlock block: @escaping ((Foundation.Notification) -> Void)) -> NSObjectProtocol {
        NotificationCenter.default.addObserver(forName: Foundation.Notification.Name(rawValue: observable.name),
                                               object: nil,
                                               queue: OperationQueue.main,
                                               using: block)
    }

    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }

}
