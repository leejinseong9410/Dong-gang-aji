//
//  Date+Extension.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/14.
//

import Foundation

extension Date {
    func timeRemain(until endData : Date) -> String? {
        
       let dateComponentsFormatter = DateComponentsFormatter()
        
        dateComponentsFormatter.allowedUnits = [.year,.month,.weekOfMonth,.day]
        
        dateComponentsFormatter.unitsStyle = .full
        
        return dateComponentsFormatter.string(from: self,to: endData)
        
    }
}
