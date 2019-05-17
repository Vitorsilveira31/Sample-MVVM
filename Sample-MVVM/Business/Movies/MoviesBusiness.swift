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

    var page: Int = 0
    
    func popular(isFirstPage: Bool = false, completion: @escaping (Result<Movies, Error>) -> Void) {
        self.page = isFirstPage ? 1 : (self.page + 1)
        self.provider.popular(page: self.page, completion: completion)
    }
}
