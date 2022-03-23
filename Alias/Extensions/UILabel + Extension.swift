//
//  UILabel + Extension.swift
//  Alias
//
//  Created by Даня on 21.02.2022.
//

import Foundation
import UIKit


//MARK: - Spacing
extension UILabel {
    var spacing: CGFloat{
        get {
            return 0
        }
        set {
            let textAlignment = self.textAlignment
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = newValue
            let attributedString = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
            self.attributedText = attributedString
            self.textAlignment = textAlignment
        }
    }
}

//MARK: - Bold text for word

extension UILabel {
    func boldString(text: String?, boldText: String?) {
        
        let attributedString = NSMutableAttributedString(string: text!)
        let range = (text! as NSString).range(of: boldText!)
        attributedString.setAttributes([NSAttributedString.Key.font: UIFont.bold(18)],
                                       range: range)
        self.attributedText = attributedString
    }
}
