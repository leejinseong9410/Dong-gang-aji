//
//  AddDDongCoordinator.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/11.
//

import Foundation
import UIKit

final class AddDDongCoordinator:CoordinatorProtocol {
   
   private(set) var childCoordinator: [CoordinatorProtocol] = []
   
    private let navigationController : UINavigationController
    
    private var presentModalNVC : UINavigationController?
    
    private var completion : (UIImage) -> Void = {_ in }
    
    var parentCoordinator : (DDongUpdateCoordinator & CoordinatorProtocol)?
    
    init(navigationController : UINavigationController){
        self.navigationController = navigationController
    }
    // 추가 ViewController의 인스턴스 생성 및 navigationController present
    func goingStart() {
        self.presentModalNVC = UINavigationController()
        let addDDongVC : AddDDongViewController = .instantiate()
        presentModalNVC?.setViewControllers([addDDongVC], animated: false )
    let addDDongVM = AddDDongViewModel(cellBuilder: DDongCellBuilder())
        addDDongVM.coordinator = self
        addDDongVC.viewModel = addDDongVM
        if let presentModalNVC = presentModalNVC {
            navigationController.present(presentModalNVC, animated: true, completion: nil)
        }
    }
    func finishAddDDong(){
        parentCoordinator?.childDidFinish(self)
    }
    func didFinishDataSave(){
        parentCoordinator?.onUpdate() 
        navigationController.dismiss(animated: true, completion: nil)
    }
    func imagePicker(completion: @escaping(UIImage) -> Void){
        print("🌁 get imagePicker")
        guard let presentModalNVC =  presentModalNVC else { return }
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: presentModalNVC)
        imagePickerCoordinator.finishPick = { image in
            print("Ok~🎇 you image ~_~")
            self.completion(image)
            self.presentModalNVC?.dismiss(animated: true, completion: nil)
        }
        imagePickerCoordinator.parentCoordinator = self
        childCoordinator.append(imagePickerCoordinator)
        imagePickerCoordinator.goingStart()
    }
    
    func childFinish(_ childCoordinatored : CoordinatorProtocol){
        if let index = childCoordinator.firstIndex(where: { coordinatored -> Bool in
                return childCoordinatored === coordinatored
        }) {
            childCoordinator.remove(at: index )
        }
    }
}
