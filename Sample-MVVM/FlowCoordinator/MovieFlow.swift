//
//  MovieFlow.swift
//  Sample-MVVM
//
//  Created by Vitor Silveira on 16/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit

enum MovieFlow {
    case start
    case toDetail
}

extension MovieFlow: Flow {
    var destination: UIViewController {
        switch self {
        case .start:
            // Aqui nós podemos verificar a partir do command launch se for teste ai fazemos o mock do serviço
            let vc = ListViewController.instantiate(with: ListViewModel(MoviesBusiness()))
            return vc
        case .toDetail:
            let viewController = UIStoryboard(name: "DetailMovie", bundle: nil).instantiateViewController(withIdentifier: "DetailMovie")
            return viewController
        }
    }
    
    var showBackButton: Bool {
        switch self {
        case .start:
            return false
        case .toDetail:
            return true
        }
    }
}
