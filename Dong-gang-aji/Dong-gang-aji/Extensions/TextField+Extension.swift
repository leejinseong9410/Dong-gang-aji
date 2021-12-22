//
//  TextField+Extension.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/11.
//

import Foundation
import UIKit

extension UITextField {
    func leftPadding(){
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.leftView = view
        self.leftViewMode = ViewMode.always
    }
    func leftImagePadding(image:UIImage) {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        view.image = image
        self.leftView = view
        self.leftViewMode = .always
    }
}
