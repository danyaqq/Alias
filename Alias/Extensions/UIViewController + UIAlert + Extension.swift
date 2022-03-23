//
//  UIViewController + UIAlert + Extension.swift
//  Alias
//
//  Created by Даня on 25.02.2022.
//

import Foundation
import UIKit

extension  UIViewController {
    func showSuccessAlert(withTitle title: String, andMessage message:String) {
        let alert = UIAlertController(title: title, message: message,
                                  preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style:
        UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
