//
//  TimeRemainStackView.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/14.
//

import Foundation
import UIKit

final class TimeRemainStackView : UIStackView {
    private let timeRemainLabels = [UILabel(),UILabel(),UILabel(),UILabel()]
    
    func setup(){
        timeRemainLabels.forEach {
            addArrangedSubview($0)
        }
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    func update(with viewModel:TimeRemainViewModel) {
        
        timeRemainLabels.forEach {
            $0.text = ""
            $0.font = .systemFont(ofSize: viewModel.fontSize,weight : .medium )
            $0.textColor = .white
        }
        
        viewModel.timeRemainPart.enumerated().forEach {
            timeRemainLabels[$0.offset].text = $0.element
        }
        alignment = viewModel.alignment
    }
}
