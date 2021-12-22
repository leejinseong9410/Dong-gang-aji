//
//  DDongService.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/16.
//

import Foundation
import UIKit
import CoreData

protocol DDongServiceProtocol {
    func perform(_ action:DDongService.DDongAction,data:DDongService.DDongDataInput)
    func getDDong(_ id:NSManagedObjectID) -> DDongs?
    func getDDongs() -> [DDongs]

}
final class DDongService : DDongServiceProtocol {
    
    struct DDongDataInput {
        let name:String
        let date:Date
        let image:UIImage
    }
    
    enum DDongAction {
        case add
        case update(DDongs)
    }
    
    private let coreDateMN : DongGangAjiCoreData
    
    init(coreDateMN:DongGangAjiCoreData = .shared) {
        self.coreDateMN = coreDateMN
    }
    
    func perform(_ action:DDongAction, data:DDongDataInput) {
        var ddong : DDongs
        
        switch action {
        case .add:
            ddong = DDongs(context: coreDateMN.ddonged)
        case .update(let dDongs):
            ddong = dDongs
        }
        ddong.setValue(data.name, forKey: "name")
        let resizeImage = data.image.aspectRatio(height: 250)
        let ddongImage = resizeImage.jpegData(compressionQuality: 0.5)
        ddong.setValue(ddongImage, forKey: "image")
        ddong.setValue(data.date, forKey: "date")
        coreDateMN.save()
    }
    func getDDong(_ id:NSManagedObjectID) -> DDongs? {
        return coreDateMN.get(id)
    }
    func getDDongs() -> [DDongs]{
        return coreDateMN.getAll()
    }
}
