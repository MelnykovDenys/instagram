//
//  AlertService.swift
//  Instagram
//
//  Created by Denys Melnykov on 18.02.2021.
//

import UIKit

final class AlertService {
    
    static let shared = AlertService()
    
    func showErrorAlert(with textError: String, on viewController: UIViewController) {
        let alert = UIAlertController(title: Localizable.error(), message: textError, preferredStyle: .alert)
        viewController.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                alert.dismiss(animated: true)
            }
        }
    }
}
