//
//  MovieFlow.swift
//  Sample-MVVM
//
//  Created by Vitor Silveira on 16/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit

enum MovieFlow {
    case movies
    case details(movie: Movie)
}

extension MovieFlow: Flow {
    var destination: UIViewController {
        switch self {
        case .movies:
            // Aqui nós podemos verificar a partir do command launch se for teste ai fazemos o mock do serviço
            let vc = ListViewController.instantiate(with: ListViewModel(MoviesBusiness()))
            return vc
        case .details(let movie):
            let vc = DetailsMovieViewController.instantiate(with: DetailsViewModel(), movie: movie)
            return vc
        }
    }
    
    var showBackButton: Bool {
        switch self {
        case .movies:
            return false
        case .details:
            return true
        }
    }
}
