//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

#if canImport(UIKit)
import UIKit

public extension UITableView {

    func isFirstCell(_ indexPath: IndexPath) -> Bool {
        indexPath.row == 0
    }

    func isLastCell(_ indexPath: IndexPath) -> Bool {
        let rows = numberOfRows(inSection: indexPath.section)
        return indexPath.row == rows - 1
    }

}

//MARK: - Keyboard Handling

public extension UITableView {

    func dismissKeyboardOnTap() {
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        endEditing(true)
    }

}

#endif
