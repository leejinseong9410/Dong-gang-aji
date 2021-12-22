//
//  EditCoordinator.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/16.
//

import Foundation

import UIKit

protocol DDongUpdateCoordinator {
    
    var onUpdate: () -> Void { get }
}

final class EditCoordinator:CoordinatorProtocol {
 
   private(set) var childCoordinator: [CoordinatorProtocol] = []
   
    private let navigationController : UINavigationController
    
    private var completion : (UIImage) -> Void = {_ in }
    
    var parentCoordinator : (DDongUpdateCoordinator & CoordinatorProtocol)?
    
    var ddong : DDongs
    
    init(ddong:DDongs,navigationController : UINavigationController){
        self.ddong = ddong
        self.navigationController = navigationController
    }
    func goingStart() {
        let editDDongVC : EditDDongViewController = .instantiate()
        let editDDongVM = EditDDongViewModel(ddong: ddong, cellBuilder: DDongCellBuilder())
        editDDongVM.coordinator = self
        editDDongVC.viewModel = editDDongVM
        navigationController.pushViewController(editDDongVC, animated: true)
    }
    func finishAddDDong(){
        parentCoordinator?.childDidFinish(self)
    }
    func didFinishDataUpdate(){
        parentCoordinator?.onUpdate()
        navigationController.popViewController(animated: true)
    }
    func imagePicker(completion: @escaping(UIImage) -> Void){
        print("🌁 get imagePicker")
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.finishPick = { image in
            completion(image)
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        childCoordinator.append(imagePickerCoordinator)
        imagePickerCoordinator.goingStart()
    }
    func childDidFinish(_ childCoordinatored : CoordinatorProtocol){

        if let index = childCoordinator.firstIndex(where: { coordinatored -> Bool in
                return childCoordinatored === coordinatored
        }) {
            childCoordinator.remove(at: index )
        }
    }
}
