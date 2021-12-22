//
//  DDongDetailCoordinator.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/14.
//

import Foundation
import UIKit
import CoreData
final class DDongDetailCoordinator:CoordinatorProtocol, DDongUpdateCoordinator{

   // var onUpdate: () -> Void

    private(set) var childCoordinator: [CoordinatorProtocol] = []
    
    private let navigationController : UINavigationController
    
    private let eventID : NSManagedObjectID
    
    var parentCoordinator : DongGangAjiCoordi?
    
    var onUpdate = {}
    
init(eventID:NSManagedObjectID,navigationController : UINavigationController) {
        self.eventID = eventID
        self.navigationController = navigationController
    }
    func goingStart() {
        let detailViewController : DDongDetailViewController = .instantiate()
        let detailViewModel = DDongDetailViewModel(eventID: eventID)
        detailViewModel.coordinator = self
        onUpdate = {
            detailViewModel.reloadDate()
            self.parentCoordinator?.onUpdate()
        }
        detailViewController.viewModel = detailViewModel
    navigationController.pushViewController(detailViewController, animated: true)
    }
    func didFinish(){
        parentCoordinator?.childDidFinish(self)
    }
    func onEdit(ddong:DDongs) {
    let editDDongCoordinator = EditCoordinator(ddong: ddong, navigationController: navigationController)
        editDDongCoordinator.parentCoordinator = self
        childCoordinator.append(editDDongCoordinator)
        editDDongCoordinator.goingStart()
    }
    func childDidFinish(_ childCoordinatored: CoordinatorProtocol) {
        if let index = childCoordinator.firstIndex(where: { coordinatored -> Bool in
                return childCoordinatored === coordinatored
        }) {
            childCoordinator.remove(at: index )
        }
    }
}
