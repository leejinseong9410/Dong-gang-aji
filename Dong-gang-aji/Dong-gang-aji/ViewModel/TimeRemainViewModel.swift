//
//  TimeRemainViewModel.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/14.
//

import Foundation
import UIKit

final class TimeRemainViewModel {
    enum Mode {
        case cell
        case detail
    }
    let timeRemainPart : [String]
    private let mode : Mode
    
    var fontSize : CGFloat {
        switch mode {
        case .cell :
            return 25
        case .detail :
            return 60
        }
    }
    
    var alignment : UIStackView.Alignment {
        switch mode {
        case .cell:
            return .trailing
        case .detail:
            return .center
        }
    }
    
    init(timeRemainPart:[String],mode: Mode) {
        self.timeRemainPart = timeRemainPart
        self.mode = mode
    }
}
