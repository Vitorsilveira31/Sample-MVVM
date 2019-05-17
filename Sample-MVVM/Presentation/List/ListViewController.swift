//
//  ListViewController.swift
//  Sample-MVVM
//
//  Created by Vitor Silveira on 16/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit

protocol ListViewContract: class {}

class ListViewController: UIViewController, ListViewContract {
    
    static func instantiate(with viewModel: ListViewModelContract) -> ListViewController {
        let vc = UIStoryboard(name: "List", bundle: nil).instantiateInitialViewController() as! ListViewController
        vc.viewModel = viewModel
        vc.viewModel?.view = vc
        return vc
    }
    
    var viewModel: ListViewModelContract?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBinding()
        self.viewModel?.getMovies()
    }
    
    func setupBinding() {
        self.viewModel?.state.bind { [weak self] state in
            switch state {
            case .normal:
                print("normal")
            case .loading:
                print("loading")
            case .loaded:
                print("loaded")
            case .reloadMovies:
                print("reloadMovies")
            }
        }
    }

}
