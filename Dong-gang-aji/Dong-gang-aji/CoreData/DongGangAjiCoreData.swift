//
//  DongGangAjiCoreData.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/09.
//

import UIKit
import CoreData

final class DongGangAjiCoreData {
    
    static let shared = DongGangAjiCoreData()
    
    lazy var dongGangAjiPersistentContainer : NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "DDongs")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    var ddonged : NSManagedObjectContext {
        dongGangAjiPersistentContainer.viewContext
    }
    func get<T : NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do{
            return try ddonged.existingObject(with: id) as? T
        }catch{
            print(error)
        }
        return nil
    }
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let ddongRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            return try ddonged.fetch(ddongRequest)
            
        }catch{
            print("😰😰😰😰😰\(error)😩😩😩😩😩 \(#line) 에러드아앙")
            return []
        }
    }
    func save(){
       do {
           try ddonged.save()
       }catch{
           print("😰😰😰😰😰\(error)😩😩😩😩😩 \(#line) 에러드아앙")
       }
    }
}
