//
//  Movies.swift
//  Sample-MVVM
//
//  Created by BTG mobile on 17/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation

struct Movies {
    let page : Int
    let results : [Movie]
    let totalPages : Int
}

struct Movie {
    let id : Int
    let overview : String
    let posterPath : String
    let releaseDate : String
    let title : String
    let voteAverage : Float
    let genres : [Genre]?
}

struct Genre {
    let id : Int
    let name : String
}
