//
//  Dynamic.swift
//  Sample-MVVM
//
//  Created by Vitor Silveira on 16/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation

class Dynamic<T> {
    typealias BindType = ((T) -> Void)
    
    // MARK: - Properties
    private var binds: [BindType] = []
    
    
    /// Dynamic raw value
    private(set) var value: T {
        didSet {
            executeBinds()
        }
    }
    
    // MARK: - Initialize
    
    /// Initializer
    ///
    /// - Parameter value: initial dynamic value
    init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Public Methods
    
    /// Bind value for changes
    ///
    /// - Parameters:
    ///   - value: accept new value in dynamic value
    func accept(_ value: T) {
        self.value = value
    }
    
    /// - Parameters:
    ///   - skip: Should skip initial closure cell
    ///   - bind: closure to execute every time value changed
    func bind(skip: Bool = false, _ bind: @escaping BindType) {
        self.binds.append(bind)
        if skip { return }
        bind(value)
    }
    
    // Mark: - Private Methods
    private func executeBinds() {
        self.binds.forEach { [unowned self] bind in
            bind(self.value)
        }
    }
}
