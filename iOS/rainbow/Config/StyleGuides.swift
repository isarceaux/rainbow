//
//  StyleGuides.swift
//  rainbow
//
//  Created by David Okun IBM on 5/10/18.
//  Copyright © 2018 IBM. All rights reserved.
//

import UIKit

extension UIColor {
    class RainbowColors {
        // generated from http://uicolor.xyz/#/hex-to-ui
        static let red = UIColor(red:0.07, green:0.66, blue:0.77, alpha:1.0)
        static let orange = UIColor(red:0.64, green:0.93, blue:0.97, alpha:1.0)
        static let yellow = UIColor(red:0.50, green:0.73, blue:1.00, alpha:1.0)
        static let green = UIColor(red:0.78, green:0.35, blue:1.00, alpha:1.0)
        static let blue = UIColor(red:0.42, green:0.67, blue:0.80, alpha:1.0)
        static let violet = UIColor(red: 0.59, green: 0.22, blue: 0.60, alpha: 1.0)
        static let copy = UIColor(red: 0.24, green: 0.32, blue: 0.44, alpha: 1.0)
        static let pale = UIColor(red: 0.90, green: 0.96, blue: 0.98, alpha: 1.0)
        static let neutral = UIColor(red: 0.96, green: 0.96, blue: 0.94, alpha: 1.0)
        static let unselectedDot = UIColor(red: 0.98, green: 0.84, blue: 0.84, alpha: 1.0)
    }
}

extension UIFont {
    class RainbowFonts {
        static func bold(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: "IBMPlexSans-Bold", size: size) else {
                return UIFont.systemFont(ofSize: size)
            }
            return font
        }

        static func medium(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: "IBMPlexSans-Medium", size: size) else {
                return UIFont.systemFont(ofSize: size)
            }
            return font
        }

        static func regular(size: CGFloat) -> UIFont {
            guard let font = UIFont(name: "IBMPlexSans-Regular", size: size) else {
                return UIFont.systemFont(ofSize: size)
            }
            return font
        }
    }
}
