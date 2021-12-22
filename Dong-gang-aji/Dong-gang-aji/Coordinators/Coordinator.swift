
import UIKit
protocol CoordinatorProtocol: AnyObject {
    var childCoordinator : [CoordinatorProtocol] { get }
    func goingStart()
   func childDidFinish(_ childCoordinator : CoordinatorProtocol)
}
extension CoordinatorProtocol {
    func childDidFinish(_ childCoordinatored : CoordinatorProtocol){ }
}
final class Coordinator : CoordinatorProtocol{
    private(set) var childCoordinator: [CoordinatorProtocol] = []
    private let window : UIWindow
    init(window:UIWindow) {
        self.window = window
    }
    func goingStart() {
        let navigationController = UINavigationController()
        let dongGangAjiCoordinator = DongGangAjiCoordi(navigationController: navigationController)
        childCoordinator.append(dongGangAjiCoordinator)
        dongGangAjiCoordinator.goingStart()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
