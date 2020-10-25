//
//  Network.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation
import CoreLocation.CLLocation

typealias Weather = MainScreen.FetchWeather.Response.Weather
typealias WeatherComplition = (Result<Weather, Error>) -> ()



protocol NetworkServiceProtocol: class {
//    associatedtype Weather
    func getJSONData(completionHandler: @escaping WeatherComplition)
    var link: String { get set }
    var way: Way { get set }
}

enum Way {
    case byCity(city: String)
    case byCoordinate(coordinate: CLLocationCoordinate2D)
}

enum UnitOfMeasurement: String {
    case metric     = "metric"
    case imperial   = "imperial"
}


final class NetworkService: NetworkServiceProtocol {
    
//    typealias Weather = MainScreen.FetchWeather.Response.Weather
    
    static let key = "6485002c6ffd1d04876d0de28d75f187"
    static let unit: UnitOfMeasurement = .metric
    
    var way: Way = .byCity(city: "Minsk") {
        didSet {
            prepareLink()
        }
    }
    
    internal var link: String = ""
    
    private func prepareLink() {
        
        switch way {
        case .byCity(var city):
            city = city.replacingOccurrences(of: " ", with: "%20")
            link = "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=\(NetworkService.unit.rawValue)&appid=\(NetworkService.key)"
        case .byCoordinate(let coordinate):
            link = "http://api.openweathermap.org/data/2.5/forecast?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&appid=\(NetworkService.key)"
            print(coordinate)
        }
        print(link)
    }
    
    func getJSONData(completionHandler: @escaping WeatherComplition) {
        let session = URLSession.shared
        
        prepareLink()
        
        guard let url = URL(string: link) else { return }
        
        let dispatchQueue = DispatchQueue(label: "com.vanjo")
        
        dispatchQueue.async {
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                    print("Server error!")
                    print((response as! HTTPURLResponse).statusCode)
                    return
                }
                
                do {
                    let weatherData = try JSONDecoder().decode(MainScreen.FetchWeather.Response.Weather.self, from: data!)
                    completionHandler(.success(weatherData))
                    
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("could not find key \(key) in JSON: \(context.debugDescription)")
                } catch DecodingError.valueNotFound(let type, let context) {
                    print("could not find type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                } catch DecodingError.dataCorrupted(let context) {
                    print("data found to be corrupted in JSON: \(context.debugDescription)")
                } catch let error as NSError {
                    completionHandler(.failure(error))
                    NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                }
                
            }
            
            task.resume()
        }
        
    }
    
}
