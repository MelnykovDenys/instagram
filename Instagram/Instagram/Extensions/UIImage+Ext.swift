//
//  UIImage+Ext.swift
//  Instagram
//
//  Created by Denys Melnykov on 18.02.2021.
//

import UIKit

extension UIImageView {
    
    func setRounded() {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}

extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}
