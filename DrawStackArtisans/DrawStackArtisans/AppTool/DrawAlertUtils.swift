//
//  Utils.swift
//  DrawStackArtisans
//
//  Created by DrawStackArtisans on 2024/10/31.
//

import UIKit

class DrawAlertUtils {
    static func showAlert(title: String, message: String, from viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
