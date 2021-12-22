//
//  ImagePickerCoordinator.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/13.
//

import Foundation
import UIKit

final class ImagePickerCoordinator : NSObject , CoordinatorProtocol {
   
    
    private(set)var childCoordinator: [CoordinatorProtocol] = []
    private let navigationController : UINavigationController?
    
    var parentCoordinator : CoordinatorProtocol?
    
    var finishPick : (UIImage) -> Void = { _ in }
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    func goingStart() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        navigationController?.present(imagePickerController, animated: true, completion: nil)
    }
}
extension ImagePickerCoordinator : UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            finishPick(image)
        }
        parentCoordinator?.childDidFinish(self)
    }
    
}
