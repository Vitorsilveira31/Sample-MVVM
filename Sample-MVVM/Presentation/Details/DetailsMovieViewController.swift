//
//  DetailsMovieViewController.swift
//  Sample-MVVM
//
//  Created by BTG mobile on 17/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit
import Kingfisher

class DetailsMovieViewController: UIViewController {
    
    static func instantiate(with viewModel: DetailsViewModelContract, movie: Movie) -> DetailsMovieViewController {
        let vc = UIStoryboard(name: "Details", bundle: nil).instantiateInitialViewController() as! DetailsMovieViewController
        vc.viewModel = viewModel
        vc.viewModel?.movie = movie
        return vc
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var viewModel: DetailsViewModelContract?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        self.viewModel?.start()
    }
    
    func setupBinding() {
        self.viewModel?.state.bind { [weak self] state in
            switch state {
            case .normal:
                print("normal")
            case .display(let movie):
                self?.posterImageView.kf.indicatorType = IndicatorType.activity
                self?.posterImageView.kf.setImage(with: URL(string: K.ApiServer.Poster(path: movie.posterPath))!)
                self?.titleLabel.text = movie.title
                self?.dateLabel.text = movie.releaseDate
                self?.overviewTextView.text = movie.overview
            case .error(let message):
                print(message)
                self?.dismiss(animated: true)
            }
        }
    }
}
