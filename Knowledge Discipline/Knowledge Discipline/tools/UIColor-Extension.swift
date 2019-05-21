//
//  UIColor-Extension.swift
//  Knowledge Discipline
//
//  Created by 朱敏 on 2019/5/21.
//  Copyright © 2019 Ora. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
