//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

#if canImport(UIKit)
import UIKit

public extension UIViewController {

    func enforceEmptyBackItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }

    var localizedTitle: String? {
        get { navigationItem.title }
        set(newTitle) { navigationItem.title = newTitle }
    }

}

#endif
