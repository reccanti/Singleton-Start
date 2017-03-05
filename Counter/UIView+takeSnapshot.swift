//
//  UIView+takeSnapshot.swift
//  Counter
//
//  Created by Benjamin Wilcox on 3/5/17.
//  Copyright © 2017 tony. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func takeSnapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image;
    }
}
