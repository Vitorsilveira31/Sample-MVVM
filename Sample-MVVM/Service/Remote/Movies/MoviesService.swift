//
//  MoviesService.swift
//  Sample-MVVM
//
//  Created by Vitor Silveira on 16/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

// MARK: - Imports
import Moya

// MARK: - Typealias

// MARK: - Protocols
protocol MoviesServiceProvider: class {
    func popular(page: Int, completion: @escaping (Result<Movies, Error>) -> Void)
}

// MARK: - Constantes

// MARK: - Enums

// MARK: - Class/Objects
class MoviesService: MoviesServiceProvider {
    
    // MARK: - Vars
    
    // MARK: - Lets
    private let apiClient: MoyaProvider<MoviesApi>
    private let preferencesService: PreferencesServiceProvider
    
    // MARK: - Initializers
    init(_ provider: MoyaProvider<MoviesApi>, preferencesService: PreferencesServiceProvider = PreferencesService.shared) {
        self.apiClient = provider
        self.preferencesService = preferencesService
    }
    
    convenience init() {
        self.init(MoyaProvider<MoviesApi>(), preferencesService: PreferencesService.shared)
    }
    // MARK: - Overrides
    
    // MARK: - Public Methods
    func popular(page: Int, completion: @escaping (Result<Movies, Error>) -> Void) {
        self.apiClient.request(.popular(page: page)) { response in
            if let value = response.value {
                if let _ = try? value.filterSuccessfulStatusCodes(), let dict = try? JSONSerialization.jsonObject(with: value.data, options: []) as? [String : Any] {
                    if let formatted = MovieFormatter.formatMovies(dict) {
                        completion(Result.success(formatted))
                    } else {
                        completion(Result.failure(NSError(domain: "Erro na conversão para o model", code: 0, userInfo: nil)))
                    }
                } else {
                    completion(Result.failure(NSError(domain: value.description, code: value.statusCode, userInfo: nil)))
                }
            } else {
                completion(Result.failure(NSError(domain: response.description, code: 0, userInfo: nil)))
            }
        }
    }
    
    // MARK: - Private Methods
    
    // MARK: - Deinitializers
}
