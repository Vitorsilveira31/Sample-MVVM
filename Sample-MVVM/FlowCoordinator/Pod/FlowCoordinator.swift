//
//  FlowCoordinator.swift
//  Sample-MVVM
//
//  Created by Vitor Silveira on 16/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit

protocol Flow {
    var destination: UIViewController { get }
    var showBackButton: Bool { get }
}

class FlowCoordinator {
    
    static let shared: FlowCoordinator = FlowCoordinator()
    
    func present(source: UIViewController, flow: Flow, completion: @escaping () -> Void = {}) {
        source.present(flow.destination, animated: true, completion: completion)
    }
    
    func navigate(source: UIViewController, flow: Flow) {
        source.show(flow.destination, sender: source)
    }
    
    func backTo(source: UIViewController, completion: @escaping () -> Void = {}) {
        source.dismiss(animated: true, completion: completion)
    }
}
