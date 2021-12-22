//
//  AddDDongViewModel.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/11.
//

import Foundation
import UIKit
import SnapKit

final class AddDDongViewModel {
    enum Mode {
        case add
        case edit(DDongs)
    }
    let title = "똥강아지 기록 남기기📸"

    var onUpdate: () -> Void = {}
    
    enum Cell {
        case ddongTitleSub(DDongTitleSubtitleViewModel)
        case ddongImage
    }
    private(set) var cells : [Cell] = []
    
    weak var coordinator : AddDDongCoordinator?
    
    private var titleCellViewModal : DDongTitleSubtitleViewModel?
    private var dateCellViewModal : DDongTitleSubtitleViewModel?
    private var imageCellViewModal : DDongTitleSubtitleViewModel?
    private let cellBuilder : DDongCellBuilder
    
    private let ddongService : DDongServiceProtocol
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter
    }()
    init(cellBuilder : DDongCellBuilder,ddongService:DDongServiceProtocol = DDongService() ) {
        self.cellBuilder = cellBuilder
        self.ddongService = ddongService
    }
    func viewDidDisappear() {
        coordinator?.finishAddDDong()
    }
    func numberOfRowsSection() -> Int {
        return cells.count
    }
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    func viewDidLoad(){
        setCells()
        onUpdate()
    }
    func tappedDone(){
        guard let name = titleCellViewModal?.subtitle,
              let dateString = dateCellViewModal?.subtitle,
              let image = imageCellViewModal?.image,
              let date = dateFormatter.date(from: dateString) else { return }
        ddongService.perform(.add,data: DDongService.DDongDataInput(name: name, date: date, image: image))
        coordinator?.didFinishDataSave()
    }
    func updateCell(indexPath:IndexPath,subtitle:String) {
        switch cells[indexPath.row] {
        case .ddongTitleSub(let titleCellViewModel) :
            titleCellViewModel.updateSubtitle(subtitle)
        default :
            print("updateCell == 🌆 디폴트~")
        }
    }
    func selectRow(at indexPath : IndexPath ) {
        switch cells[indexPath.row] {
        case .ddongTitleSub(let ddongTitleSubtitleCellModel) :
            guard ddongTitleSubtitleCellModel.type == .image else { return }
            coordinator?.imagePicker { image in
                ddongTitleSubtitleCellModel.updateImage(image)
            }
        default :
            print("selectRow == 🌆 디폴트~")
        }
    }
}
private extension AddDDongViewModel {
    func setCells(){
        titleCellViewModal = cellBuilder.makeTitlesubtitleViewModel(.text)
        dateCellViewModal = cellBuilder.makeTitlesubtitleViewModel(.date) {
            [weak self] in
            self?.onUpdate()
        }
        imageCellViewModal = cellBuilder.makeTitlesubtitleViewModel(.image) {
            [weak self] in
            self?.onUpdate()
        }
        guard let titleCellViewModal = titleCellViewModal , let dateCellViewModal = dateCellViewModal , let imageCellViewModal = imageCellViewModal else { return }
        cells =
        [
            .ddongTitleSub(
                titleCellViewModal
            ),
            .ddongTitleSub(
                dateCellViewModal
            ),
            .ddongTitleSub(
                imageCellViewModal
            )
        ]
    }
}
