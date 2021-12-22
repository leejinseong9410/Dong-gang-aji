//
//  DDongTitleSubtitleViewModel.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/11.
//

import Foundation
import UIKit

final class  DDongTitleSubtitleViewModel {
    
    enum CellType{
        case text
        case date
        case image
    }
    let title : String
    
    private(set) var subtitle : String
    
    let placeholder : String
    
    let type : CellType
    
    
   lazy var dateFormatter : DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    private(set) var image : UIImage?
    
    private(set) var onCellUpdate: (() -> Void)?
    
    
    init(title:String,subtitle:String,placeholder:String,type:CellType,onCellUpdate:(() -> Void)?) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    func updateSubtitle(_ subtitle: String ) {
        self.subtitle = subtitle
    }
    func updateDate(_ date : Date ) {
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        onCellUpdate?()
    }
    func updateImage(_ image: UIImage) {
        self.image = image
        onCellUpdate?()
    }
}
