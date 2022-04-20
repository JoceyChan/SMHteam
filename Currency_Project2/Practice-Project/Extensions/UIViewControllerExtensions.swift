//
//  UIWindowExtension.swift
//  Practice-Project
//
//  Created by Ricardo Sanchez-Macias on 4/14/22.
//

import UIKit

extension UIViewController {
    func inLandscapeMode() -> Bool? {
        if #available(iOS 13.0, *) {
            return self.view.window?.windowScene?.interfaceOrientation.isLandscape
        } else {
            return UIApplication.shared.statusBarOrientation.isLandscape
        }
    }
}
