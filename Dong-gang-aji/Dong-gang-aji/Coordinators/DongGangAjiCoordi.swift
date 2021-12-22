
import UIKit
import CoreData

final class DongGangAjiCoordi : CoordinatorProtocol, DDongUpdateCoordinator {
    private(set) var childCoordinator: [CoordinatorProtocol] = []
    var onUpdate = {}
    private let navigationController : UINavigationController
    init(navigationController : UINavigationController ) {
        self.navigationController = navigationController
    }
    // 쓰레드가 시작되면 가장 먼저 실행되게될 메소드
    func goingStart() {
        // 바로 ViewController를 열지 않고 이곳 즉 MainViewController를 담당할 Coordinator에 위임하여 ViewController의 인스턴스를 생성하여 열게된다.
        let dongGangAjiVC : DongGangAjiViewController = .instantiate()
        let ddongViewModel = DongGangAjiViewModel()
        // delegatePattern과 유사 하다 볼수 있다.
        // ViewController의 ViewModel에게 coordinator를 연결하고 작업이 진행되게 된다.
        ddongViewModel.coordinator = self
        // ViewController에서 위임받게될 메소드 테이블을 reloadData 시켜준다
        onUpdate = ddongViewModel.reload
        dongGangAjiVC.ddongViewModel = ddongViewModel
        // 한번 뷰를 열게되면 스텍에 가지고있을것이기 때문에 setViewControllers 에 인스턴스를 추가해준뒤 진행하게된다.
        navigationController.setViewControllers([dongGangAjiVC], animated: false)
    }
    
    // 추가 버튼을 누르게 되었을때 실행되게될 메소드
    func addDDongEvent(){
        // 추가를 담당하게 될 ViewController의 Coordinator 인스턴스를 생성해준다.
        // CoordinatorProtocol를 상속 받기 때문에 상속Properties로 인해 init변수로 navigation을 보내주어야함
        let addDDong = AddDDongCoordinator(navigationController : navigationController)
        // deletatePattern이라고 볼수있는 parentCoordinator = self 현재의 coordinator와 연결해준다 delegate가 작동됨
        addDDong.parentCoordinator = self
        // childCoordinator에 appen 해줌으로써 스텍에서 유지시켜 뷰전환시 무리없이 진행할수있다.
        childCoordinator.append(addDDong)
        // 추가 ViewController의 인스턴스를 생성하고 뷰를 열어주는 메소드를 실행.
        addDDong.goingStart()
    }
    
    //TableViewController에 cell을 tap 하였을시 실행되게될 메소드
    func onSelect(_ id : NSManagedObjectID){
        print("==⭐️🐶왕왕==")
        // DetailViewController의 인스턴스와 eventID 즉 user가 열고자하는 객체의 id를 전달해주게 된다.
let coordinatorDetail = DDongDetailCoordinator(eventID: id, navigationController: navigationController)
        // deletatePattern이라고 볼수있는 parentCoordinator = self 현재의 coordinator와 연결해준다 delegate가 작동됨
        coordinatorDetail.parentCoordinator = self
        // childCoordinator에 appen 해줌으로써 스텍에서 유지시켜 뷰전환시 무리없이 진행할수있다.
        childCoordinator.append(coordinatorDetail)
        // 디테일 ViewController의 인스턴스를 생성하고 뷰를 열어주는 메소드를 실행.
        coordinatorDetail.goingStart()
    }
}
