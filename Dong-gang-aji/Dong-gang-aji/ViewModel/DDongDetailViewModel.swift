//
//  DDongDetailViewModel.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/14.
//

import Foundation
import CoreData
import UIKit

final class DDongDetailViewModel {
    
    private let eventID:NSManagedObjectID
    
    private let ddongService:DDongServiceProtocol
    
    private var dongGangAjis : DDongs?
    
    var coordinator : DDongDetailCoordinator?
    
    private let date = Date()
    
    var onUpdate = {}
    
    var timeRemainViewModel : TimeRemainViewModel? {
        guard let ddongDate = dongGangAjis?.date,
                let timeRemainPart = date.timeRemain(until: ddongDate)?.components(separatedBy: ",") else { return nil }
            return TimeRemainViewModel(timeRemainPart: timeRemainPart, mode: .detail)
    }
    var image:UIImage? {
        guard let imageData = dongGangAjis?.image else { return nil }
        return UIImage(data: imageData)
    }
    
    
    init(eventID:NSManagedObjectID,ddongService:DDongServiceProtocol = DDongService()) {
        self.eventID = eventID
        self.ddongService = ddongService
    }
    
    func viewDidload(){
        reloadDate()
    }
    func viewDidDisappear(){
        coordinator?.didFinish()
    }
    func reloadDate(){
        dongGangAjis = ddongService.getDDong(eventID)
        onUpdate()
    }
    @objc func editButtonTapped(){
        guard let dongGangAjis = dongGangAjis else { return }
        coordinator?.onEdit(ddong: dongGangAjis)
    }
}
