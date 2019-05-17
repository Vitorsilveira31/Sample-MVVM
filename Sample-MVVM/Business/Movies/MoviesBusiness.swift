//
//  MoviesBusiness.swift
//  Sample-MVVM
//
//  Created by Vitor Silveira on 16/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation

class MoviesBusiness {
    
    let provider: MoviesServiceProvider
    
    init(provider: MoviesServiceProvider) {
        self.provider = provider
    }
    
    convenience init() {
        self.init(provider: MoviesService())
    }
    
    func popular(page: String, completion: @escaping (Result<String, Error>) -> Void) {
        // self.provider
    }

    func details(movieId: String, completion: @escaping (Result<String, Error>) -> Void) {
        // self.provider
    }
    
    func favorite(movie: String, completion: @escaping (Bool) -> Void) {
        // self.provider
    }
    
    func unfavorite(movie: String, completion: @escaping (Bool) -> Void) {
        // self.provider
    }
    
    func isFavorite(movie: String, completion: @escaping (Bool) -> Void) {
        // self.provider
    }
}
