//
//  DDongTitleSubtitleCell.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/11.
//

import Foundation
import SnapKit

final class DDongTitleSubtitleCell : UITableViewCell {
    
    private let titleLabel = UILabel()
    
    let subtitleTextField = UITextField()
    
    private let verticalStackView = UIStackView()
    
    private let stackOffset : CGFloat = 20
    
    private let datePickerView = UIDatePicker()
    
    private let toolbar = UIToolbar(frame:.init(x: 0, y: 0, width: 100, height: 50))
    
    private var viewModel : DDongTitleSubtitleViewModel?
    
    private let dogPhotoImageView = UIImageView()
    
    lazy var doneButton : UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewSetup()
        hierarchySetup()
        layoutSetup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateViewModel(with viewModel : DDongTitleSubtitleViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeholder
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolbar
        dogPhotoImageView.isHidden = viewModel.type != .image
        subtitleTextField.isHidden = viewModel.type == .image
        dogPhotoImageView.image = viewModel.image
        verticalStackView.spacing = viewModel.type == .image ? 15 : verticalStackView.spacing
        verticalStackView.spacing = viewModel.type == .text ? 10 : verticalStackView.spacing
        verticalStackView.spacing = viewModel.type == .date ? 10 : verticalStackView.spacing

    }
    private func viewSetup(){
        verticalStackView.axis = .vertical
        titleLabel.font = UIFont.systemFont(ofSize: 22,weight: .bold)
        subtitleTextField.font = UIFont.systemFont(ofSize: 15,weight: .medium)
        subtitleTextField.leftPadding()
        toolbar.setItems([doneButton], animated: false)
        datePickerView.preferredDatePickerStyle = .wheels
        datePickerView.datePickerMode = .date
        dogPhotoImageView.backgroundColor = .blue.withAlphaComponent(0.4)
        dogPhotoImageView.layer.cornerRadius = 10
    }
    private func hierarchySetup(){
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(dogPhotoImageView)
    }
    private func layoutSetup(){
        verticalStackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(stackOffset)
            make.left.equalTo(contentView.snp.left).offset(stackOffset)
            make.bottom.equalTo(contentView.snp.bottom).offset(-stackOffset)
            make.right.equalTo(contentView.snp.right).offset(-stackOffset)
        }
        dogPhotoImageView.snp.makeConstraints { (make) in
            make.height.equalTo(200)
        }
    }
   @objc private func tappedDone(){
        print("📸tapped Done!!!!!ㅎㅎ")
       viewModel?.updateDate(datePickerView.date)
    }
}
