
import Foundation
final class DongGangAjiViewModel {
    let title = "똥강아지🐶"
    
    var coordinator : DongGangAjiCoordi?
    
    var onUpdate = {}
    
    enum Cell {
        case event(DDongCellViewModel)
    }
    private(set) var cells : [Cell] = []
    
    private let ddongService : DDongServiceProtocol
    
    init(ddongService:DDongServiceProtocol = DDongService()) {
        
        self.ddongService = ddongService
    }
    
    func viewDidLoad(){
        reload()
    }
    func reload(){
        DDongCellViewModel.imageCache.removeAllObjects()
        let ddongs = ddongService.getDDongs()
        cells = ddongs.map {
            var ddongCellViewModel = DDongCellViewModel($0)
            if let coordinator = coordinator {
                ddongCellViewModel.onSelect = coordinator.onSelect
            }
            return.event(ddongCellViewModel)
        }
        onUpdate()
    }
    func tappedAdd(){
        print("왈왈!🐶")
        coordinator?.addDDongEvent()
    }
    func numberOfRows() -> Int {
        return cells.count
    }
    func cell(at indexPath:IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    func didSelectRowAt(at indexPath : IndexPath) {
        switch cells[indexPath.row] {
        case .event(let ddongCellViewModel) :
            ddongCellViewModel.didSelect()
        }
    }
}
