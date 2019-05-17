//
//  MoviesFormatter.swift
//  Sample-MVVM
//
//  Created by BTG mobile on 17/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation

class MovieFormatter {
    
    static var formatMovies: ([String : Any]) -> Movies? = { dict in
        if let totalPages = dict["total_pages"] as? Int,
            let page = dict["page"] as? Int,
            let resultsMap = dict["results"] as? [[String:Any]] {
            var results: [Movie] = []
            resultsMap.forEach { item in
                if let id = item["id"] as? Int,
                    let overview = item["overview"] as? String,
                    let posterPath = item["poster_path"] as? String,
                    let releaseDate = item["release_date"] as? String,
                    let title = item["title"] as? String,
                    let voteAverage = item["vote_average"] as? Float {
                    results.append(Movie(id: id, overview: overview, posterPath: posterPath, releaseDate: releaseDate, title: title, voteAverage: voteAverage, genres: item["genres"] as? [Genre]))
                }
            }
            return Movies(page: page, results: results, totalPages: totalPages)
        }
        return nil
    }
}
