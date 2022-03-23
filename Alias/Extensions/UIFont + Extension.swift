//
//  UIFont + Extension.swift
//  Alias
//
//  Created by Даня on 21.02.2022.
//

import Foundation
import UIKit


extension UIFont{
    static func bold(_ size: CGFloat)-> UIFont{
        return UIFont(name: "YanoneKaffeesatz-Bold", size: size)!
    }
    static func semiBold(_ size: CGFloat)-> UIFont{
        return UIFont(name: "YanoneKaffeesatz-SemiBold", size: size)!
    }
    static func regular(_ size: CGFloat)-> UIFont{
        return UIFont(name: "YanoneKaffeesatz-Regular", size: size)!
    }
    static func medium(_ size: CGFloat)-> UIFont{
        return UIFont(name: "YanoneKaffeesatz-Medium", size: size)!
    }
}
