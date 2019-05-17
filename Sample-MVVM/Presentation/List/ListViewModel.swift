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
    var view: ListViewContract? { get set }
    var state: Dynamic<ListStates> { get }
    func getMovies()
    func favoriteMovie(id: Int)
    func unfavoriteMovie(id: Int)
}

enum ListStates {
    case normal
    case loading
    case loaded
    case reloadMovies
}

class ListViewModel: ListViewModelContract {
    
    private let business: MoviesBusiness
    
    var view: ListViewContract?
    var state: Dynamic<ListStates>
    
    required init(_ business: MoviesBusiness) {
        self.business = business
        self.state = Dynamic<ListStates>(.normal)
    }
    
    func getMovies() {
        self.state.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.state.accept(.loaded)
        }
    }
    
    func favoriteMovie(id: Int) {
        
    }
    
    func unfavoriteMovie(id: Int) {
        
    }
}
