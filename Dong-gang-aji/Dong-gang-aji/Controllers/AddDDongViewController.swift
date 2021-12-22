//
//  AddDDongViewController.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/11.
//

import UIKit
import RxSwift
import RxCocoa

class AddDDongViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : AddDDongViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        viewModel.onUpdate = {
            [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    @objc private func doneTapped(){
        viewModel.tappedDone()
    }
    private func viewSetup(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DDongTitleSubtitleCell.self, forCellReuseIdentifier: "DDongTitleSubtitleCell")
        tableView.tableFooterView = UIView()
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        navigationController?.navigationBar.tintColor = .black
        tableView.contentInsetAdjustmentBehavior = .always
        tableView.setContentOffset(.init(x: 0, y: -2), animated: true)
    }
}
extension AddDDongViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectRow(at: indexPath )
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
extension AddDDongViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsSection()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = viewModel.cell(for:indexPath)
        switch cellVM {
        case .ddongTitleSub(let dDongTitleSubtitleViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: "DDongTitleSubtitleCell", for: indexPath) as! DDongTitleSubtitleCell
            cell.updateViewModel(with: dDongTitleSubtitleViewModel)
            cell.subtitleTextField.delegate = self
            return cell
        default :
           return UITableViewCell()
        }
    }
    
}
extension AddDDongViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        let point = textField.convert(textField.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            viewModel.updateCell(indexPath : indexPath,subtitle:text) 
        }
        return true
    }
}
