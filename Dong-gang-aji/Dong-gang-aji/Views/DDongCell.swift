//
//  DDongCell.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/14.
//

import Foundation
import UIKit

final class DDongCell : UITableViewCell {
    
    private let timeRemainStackView = TimeRemainStackView()

    private let dateLabel = UILabel()
    
    private let eventNameLabel = UILabel()
    
    private let backImage = UIImageView()
    
    private let verticalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewSetup()
        hierarchySetup()
        layoutSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewSetup() {
        timeRemainStackView.setup()
  [dateLabel,eventNameLabel,backImage,verticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        dateLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dateLabel.textColor = .white
        eventNameLabel.font = .systemFont(ofSize: 34, weight: .bold)
        eventNameLabel.textColor = .white
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
    }
    private func hierarchySetup(){
        contentView.addSubview(backImage)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)
        verticalStackView.addArrangedSubview(timeRemainStackView)
        verticalStackView.addArrangedSubview(dateLabel)
    }
    private func layoutSetup(){
        backImage.pintoSuperView([.left,.top,.right],constant: 0)
        let bottomConstant = backImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstant.priority = .required - 1
        bottomConstant.isActive = true
        backImage.heightAnchor.constraint(equalToConstant: 250).isActive = true
        verticalStackView.pintoSuperView([.top,.right,.bottom],constant: 15)
        eventNameLabel.pintoSuperView([.left,.bottom],constant: 15)
    }
    func update(with viewModel : DDongCellViewModel ) {
        if let timeRemainViewModel = viewModel.timeRemainViewModel {
            timeRemainStackView.update(with: timeRemainViewModel )
        }
        dateLabel.text = viewModel.dateText
        eventNameLabel.text = viewModel.eventName
        viewModel.loadImage { image in
            self.backImage.image = image
        }
    }
}
