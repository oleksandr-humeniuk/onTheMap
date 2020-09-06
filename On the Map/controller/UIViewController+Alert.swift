//
//  UIViewController+Alert.swift
//  On the Map
//
//  Created by Oleksandr Humeniuk on 9/6/20.
//

import UIKit

extension UIViewController {
    func showAlert(title:String? = nil,message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
