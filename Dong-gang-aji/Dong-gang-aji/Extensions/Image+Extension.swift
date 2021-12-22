//
//  Image+Extension.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/14.
//

import Foundation
import UIKit

extension UIImage {
    func aspectRatio(height:CGFloat) -> UIImage {
        let scale = height / size.height
        let width = size.width * scale
        let newSize = CGSize(width: width, height: height)
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: .init(origin: .zero, size: newSize))
        }
    }
}
