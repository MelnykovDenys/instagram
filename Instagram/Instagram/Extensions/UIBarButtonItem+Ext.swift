//
//  UIBarButtonItem+Ext.swift
//  Instagram
//
//  Created by Denys Melnykov on 19.02.2021.
//

import UIKit

extension UIBarButtonItem {
    
    static func instaBarButton(with icon: UIImage?) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.tintColor = Colors.black()
        barButtonItem.image = icon
        return barButtonItem
    }
}
