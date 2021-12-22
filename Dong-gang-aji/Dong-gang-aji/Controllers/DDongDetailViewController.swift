//
//  DDongDetailViewController.swift
//  Dong-gang-aji
//
//  Created by MacBookPro on 2021/11/14.
//


import UIKit

final class DDongDetailViewController : UIViewController {
    
    @IBOutlet weak var backImageView: UIImageView!
    
    @IBOutlet weak var timeRemainStackView: TimeRemainStackView! {
        didSet{
            timeRemainStackView.setup()
        }
    }
    
    var viewModel : DDongDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onUpdate = { [weak self] in
        guard let self = self,let timeRemainStackView = self.viewModel.timeRemainViewModel else { return }
            self.backImageView.image = self.viewModel.image
            self.timeRemainStackView.update(with: timeRemainStackView)
        }
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "pencil"), style: .plain, target: viewModel, action: #selector(viewModel.editButtonTapped))
        viewModel.viewDidload()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
