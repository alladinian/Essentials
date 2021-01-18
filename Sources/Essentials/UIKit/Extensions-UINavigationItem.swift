//
//  File.swift
//  
//
//  Created by Vasilis Akoinoglou on 18/1/21.
//

#if canImport(UIKit)
import UIKit

//MARK: - Navigation Title

public extension UINavigationItem {

    func setTitle(title: String, subtitle: String, font: UIFont? = nil) {
        let one           = UILabel()
        one.text          = title
        one.textAlignment = .center
        if let font = font {
            one.font = font
        }
        one.sizeToFit()

        if subtitle == "" {
            self.titleView = one
            return
        }

        let two           = UILabel()
        two.text          = subtitle
        two.textAlignment = .center
        if let font = font {
            two.font = font
        }
        two.sizeToFit()

        let stackView          = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis         = .vertical

        let width       = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)

        one.sizeToFit()
        two.sizeToFit()

        self.titleView = stackView
    }

}

#endif
