//
//  ViewController+Extension.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/11.
//

import Foundation
import UIKit

extension UIViewController {
    //MARK: - storyboard.instantiateViewController
     static func instantiate<T>() -> T {
         let storyboard = UIStoryboard(name: "Main", bundle: .main)
         let controller = storyboard.instantiateViewController(withIdentifier: "\(T.self)") as! T
         return controller
     }
}
