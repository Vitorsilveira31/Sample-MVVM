//
//  ListViewModel.swift
//  Sample-MVVM
//
//  Created by Vitor Silveira on 16/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation

protocol ListViewModelContract: class {
    init(_ business: MoviesBusiness)
    var state: Dynamic<ListStates> { get }
    var movies: [FormattedMovies] { get }
    func getMovies(isFirstPage: Bool)
    func moveToDetails(in vc:ListViewController, at index: Int)
}

enum ListStates {
    case normal
    case loading
    case popularMoviesSuccess
    case error(message: String)
}

class ListViewModel: ListViewModelContract {
    
    private let business: MoviesBusiness
    
    var state: Dynamic<ListStates>
    var movies: [FormattedMovies]
    var _movies: [Movie]
    
    required init(_ business: MoviesBusiness) {
        self.business = business
        self.state = Dynamic<ListStates>(.normal)
        self.movies = [FormattedMovies]()
        self._movies = [Movie]()
    }
    
    func getMovies(isFirstPage: Bool) {
        self.state.accept(.loading)
        if isFirstPage { self._movies = [] }
        self.business.popular(isFirstPage: isFirstPage) { response in
            switch response {
            case .success(let movies):
                self._movies.append(contentsOf: movies.results)
                movies.results.forEach { movie in
                    self.movies.append(FormattedMovies(title: movie.title))
                }
                self.state.accept(.popularMoviesSuccess)
            case .failure(let error):
                self.state.accept(.error(message: error.localizedDescription))
            }
        }
    }
    
    func moveToDetails(in vc: ListViewController, at index: Int) {
        FlowCoordinator.shared.navigate(source: vc, flow: MovieFlow.details(movie: self._movies[index]))
    }

}
