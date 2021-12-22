
import UIKit
import CoreData

class DongGangAjiViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var ddongViewModel : DongGangAjiViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        barButtonSetUp()
        ddongViewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        ddongViewModel.viewDidLoad()
    }
    private func configureUI(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DDongCell.self, forCellReuseIdentifier: "DDongCell")
    }
    private func barButtonSetUp(){
        let addImage = UIImage(systemName: "plus.circle.fill")
        let addBarButtonItem = UIBarButtonItem(image: addImage, style: .plain, target: self, action: #selector(tappedAddBarButton))
        addBarButtonItem.tintColor = .primary
        navigationItem.rightBarButtonItem = addBarButtonItem
        navigationItem.title = ddongViewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    @objc fileprivate func tappedAddBarButton(){
         print("==tapped Rignt Bar Item==")
        ddongViewModel.tappedAdd()
    }
}
extension DongGangAjiViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch ddongViewModel.cell(at:indexPath) {
        case .event(let ddongCellViewModel) :
            let cell = tableView.dequeueReusableCell(withIdentifier: "DDongCell", for: indexPath) as! DDongCell
            cell.update(with: ddongCellViewModel)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ddongViewModel.numberOfRows()
    }
}
extension DongGangAjiViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ddongViewModel.didSelectRowAt(at:indexPath)
    }
}
