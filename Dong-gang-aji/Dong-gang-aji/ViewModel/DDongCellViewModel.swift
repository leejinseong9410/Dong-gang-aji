//
//  DDongCellViewModel.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/14.
//

import Foundation
import UIKit
import CoreData

struct DDongCellViewModel {
    
    private let ddong : DDongs
    
    init(_ ddong : DDongs) {
        self.ddong = ddong
    }
    
    let date = Date()
    
    static let imageCache = NSCache<NSString,UIImage>()
    
    private let imageQueue = DispatchQueue(label: "imageQueue",qos: .background)
    var onSelect : (NSManagedObjectID) -> Void = { _ in}
    
    private var cacheKey : String {
        ddong.objectID.description
    }
    var timeRemain : [String] {
        
        guard let ddongDate = ddong.date else { return [] }
        
        return date.timeRemain(until: ddongDate)?.components(separatedBy: ",") ?? []
    }
    var dateText : String? {
        guard let ddongDate = ddong.date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: ddongDate)
    }
    var eventName: String? {
        ddong.name
    }
    var timeRemainViewModel : TimeRemainViewModel? {
    guard let ddongDate = ddong.date,
            let timeRemainPart = date.timeRemain(until: ddongDate)?.components(separatedBy: ",") else { return nil }
        return TimeRemainViewModel(timeRemainPart: timeRemainPart, mode: .cell)
    }
    func loadImage(completion: @escaping(UIImage?) -> Void ) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        }else{
            imageQueue.async {
                guard let imageData = self.ddong.image ,let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
                  Self.imageCache.setObject(image, forKey: cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    func didSelect(){
        onSelect(ddong.objectID)
    }
}
