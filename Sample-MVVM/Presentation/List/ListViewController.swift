//
//  ListViewController.swift
//  Sample-MVVM
//
//  Created by Vitor Silveira on 16/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit
import SwiftOverlays

class ListViewController: UIViewController {
    
    static func instantiate(with viewModel: ListViewModelContract) -> ListViewController {
        let vc = UIStoryboard(name: "List", bundle: nil).instantiateInitialViewController() as! ListViewController
        vc.viewModel = viewModel
        return vc
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ListViewModelContract?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupBinding()
        self.viewModel?.getMovies(isFirstPage: true)
    }
    
    func setupView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func setupBinding() {
        self.viewModel?.state.bind { [weak self] state in
            switch state {
            case .normal:
                SwiftOverlays.removeAllBlockingOverlays()
            case .loading:
                SwiftOverlays.showBlockingWaitOverlay()
            case .popularMoviesSuccess:
                SwiftOverlays.removeAllBlockingOverlays()
                self?.tableView.reloadData()
            case .error(let message):
                SwiftOverlays.removeAllBlockingOverlays()
                print(message)
            }
        }
    }

}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.moveToDetails(in: self, at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        if let item = viewModel?.movies[indexPath.row] {
            cell.textLabel?.text = item.title
        }
        
        return cell
    }
}

extension ListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            self.viewModel?.getMovies(isFirstPage: false)
        }
    }
}
