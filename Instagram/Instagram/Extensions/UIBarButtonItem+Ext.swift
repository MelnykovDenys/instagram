//
//  UIBarButtonItem+Ext.swift
//  Instagram
//
//  Created by Denys Melnykov on 19.02.2021.
//

import UIKit

extension UIBarButtonItem {
    
    func instaBarButton(with icon: UIImage?) {
        tintColor = Colors.black()
        image = icon
    }
}
