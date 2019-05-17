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
    
    func present(source: UIViewController, flow: Flow, completion: (() -> Void)? = nil) {
        source.present(flow.destination, animated: true, completion: completion)
    }
    
    func navigate(source: UIViewController, flow: Flow) {
        source.show(flow.destination, sender: source)
    }
}
