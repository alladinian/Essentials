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

    func setTitle(title: String?, subtitle: String?, font: UIFont? = nil, image: UIImage? = nil) {
        let one = UILabel()
        one.text = title
        if let font = font {
            one.font = font
        }
        one.adjustsFontSizeToFitWidth = true
        one.textAlignment             = .center
        one.setContentCompressionResistancePriority(.required, for: .vertical)
        one.sizeToFit()

        if subtitle?.isEmpty == true {
            self.titleView = one
            return
        }

        let two = UILabel()
        two.text = subtitle
        if let font = font {
            two.font = font
        }
        two.adjustsFontSizeToFitWidth = true
        two.minimumScaleFactor        = 0.8
        two.lineBreakMode             = .byTruncatingTail
        two.textAlignment             = .center
        two.setContentCompressionResistancePriority(.required, for: .vertical)
        two.sizeToFit()

        let stackView = UIStackView(arrangedSubviews: [one, two])
        stackView.distribution = .equalCentering
        stackView.axis         = .vertical

        let width       = max(one.frame.size.width, two.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)

        one.sizeToFit()
        two.sizeToFit()

        guard let image = image else {
            self.titleView = stackView
            return
        }

        let iv = UIImageView(image: image)
        let sp = UIView()
        let w = stackView.bounds.height - 12
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: w).isActive = true
        iv.contentMode = .scaleAspectFit
        sp.widthAnchor.constraint(equalToConstant: w).isActive = true
        let hstack = UIStackView(arrangedSubviews: [iv, stackView, sp])
        hstack.distribution = .equalCentering
        hstack.axis         = .horizontal
        hstack.spacing = 8
        self.titleView = hstack

    }

}

#endif
