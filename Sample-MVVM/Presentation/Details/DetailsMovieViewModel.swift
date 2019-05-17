//
//  DetailsMovieViewModel.swift
//  Sample-MVVM
//
//  Created by BTG mobile on 17/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation

protocol DetailsViewModelContract: class {
    init()
    var state: Dynamic<DetailsStates> { get }
    var movie: Movie? { get set }
    func start()
}

enum DetailsStates {
    case normal
    case display(movie: FormattedMovieDetails)
    case error(message: String)
}

class DetailsViewModel: DetailsViewModelContract {
    
    var state: Dynamic<DetailsStates>
    var movie: Movie?
    
    required init() {
        self.state = Dynamic<DetailsStates>(.normal)
    }
    
    func start() {
        if let movie = self.movie {
            self.state.accept(.display(movie: FormattedMovieDetails(posterPath: movie.posterPath, title: movie.title, releaseDate: movie.releaseDate, overview: movie.overview)))
        } else {
            self.state.accept(.error(message: "Filme não encontrado!"))
        }
    }
}
