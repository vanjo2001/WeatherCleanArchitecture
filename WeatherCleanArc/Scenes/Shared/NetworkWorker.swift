//
//  NetworkWorker.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 24.10.20.
//

import UIKit


protocol NetworkWorkerProtocol {
    func execute(id: Int64?, complitionHandler: @escaping (Result<(weather: Weather, id: Int64?), Error>) -> ())
}

final class NetworkWorker: NetworkWorkerProtocol {
    var networkService: NetworkServiceProtocol!
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }

    func execute(id: Int64?,
                 complitionHandler: @escaping (Result<(weather: Weather, id: Int64?), Error>) -> ()) {
        networkService.getJSONData() { (result) in
            switch result {
            case .success(let weather):
                complitionHandler(.success((weather, id)))
            case .failure(let error):
                complitionHandler(.failure(error))
            }
        }
    }
    
    
}

