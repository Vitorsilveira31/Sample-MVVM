//
//  PreferencesService.swift
//  Sample-MVVM
//
//  Created by Vitor Silveira on 16/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import Foundation

// MARK: - Typealias

// MARK: - Protocols
protocol PreferencesServiceProvider {
    func store(_ value: Any, forKey key: UserDefaults.Key)
    func store<T:Encodable>(encodable: T, forKey key: UserDefaults.Key) throws
    func get<T>(_ key: UserDefaults.Key) -> T?
    func get<T: Decodable>(decodable key: UserDefaults.Key) -> T?
    func remove(key: UserDefaults.Key)
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class PreferencesService: PreferencesServiceProvider {

    // MARK: - Vars

    // MARK: - Lets
    static let shared: PreferencesServiceProvider = PreferencesService()
    
    // MARK: - Initializers
    
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func store(_ value: Any, forKey key: UserDefaults.Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func store<T>(encodable value: T, forKey key: UserDefaults.Key) throws where T : Encodable {
        let json = try JSONEncoder().encode(value)
        UserDefaults.standard.set(json, forKey: key.rawValue)
    }
    
    func get<T>(_ key: UserDefaults.Key) -> T? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? T
    }
    
    func get<T>(decodable key: UserDefaults.Key) -> T? where T : Decodable {
        guard let json = UserDefaults.standard.data(forKey: key.rawValue), let result = try? JSONDecoder().decode(T.self, from: json) else { return nil }
        
        return result
    }
    
    func remove(key: UserDefaults.Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}

extension UserDefaults {
    enum Key: String {
        case favoriteMovies
    }
}
