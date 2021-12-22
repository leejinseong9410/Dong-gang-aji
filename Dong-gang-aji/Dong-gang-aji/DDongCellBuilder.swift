//
//  DDongCellBuilder.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/13.
//

import Foundation

struct DDongCellBuilder {
    func makeTitlesubtitleViewModel(_ type: DDongTitleSubtitleViewModel.CellType,cellUpdate:(()->Void)? = nil) -> DDongTitleSubtitleViewModel {
        switch type {
        case .text:
           return DDongTitleSubtitleViewModel(
                title: "🐶제목",
                subtitle: "",
                placeholder: "제목을 입력해주세왈왈!🐶",
                type: .text,
                onCellUpdate: cellUpdate
            )
        case .date:
            return DDongTitleSubtitleViewModel(
                title: "🐶날짜",
                subtitle: "",
                placeholder: "날짜를 설정해주세왈왈!🐶",
                type: .date,
                onCellUpdate: cellUpdate
            )
        case .image:
            return DDongTitleSubtitleViewModel(
                title: "🐶사진",
                subtitle: "",
                placeholder: "",
                type: .image,
                onCellUpdate: cellUpdate
            )
        }
    }
}
