//
//  MainScreenModels.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 18.10.20.
//

import UIKit

enum MainScreen {
    // MARK: Use cases
    
    enum DefaultListOfCities {
        
        struct Request {
            var indexRow: Int
            var cityByCoordinate: CityInfo?
            var cities: [CityInfo]?
        }
        
        struct Response: Decodable {
            var cities: [CityInfo]
            var currentCity: CityInfo?
            var weather: Weather?
            var error: Error?
            
            private enum CodingKeys: String, CodingKey {
                case cities
            }
        }
        
        struct ViewModel: Decodable {
            var cities: [CityInfo]?
            var fullInfo: String
        }
        
        
        struct CityInfo: Decodable {
            var city: String
            var code: String
            var description: String
        }
        
    }
    
    
    enum FetchWeather {
        
        struct Request {
        }
        
        struct Response {
            var weatherByCity: Weather
            
            struct Weather: Decodable {
                var id: Int64 = 0
                var cod: String?
                var message: Int?
                var list: [MainInfo]
                var city: City?
                
                private enum CodingKeys: String, CodingKey {
                    case cod, message, list, city
                }
                
                static func convert(weather: WeatherEntity?) -> Self? {
                    if let weather = weather {
                        return Weather(id: weather.weatherId,
                                       cod: "",
                                       message: nil,
                                       list: [MainInfo(weather: [SubWeather(description: weather.weatherDescription)],
                                                       main: Main(temp: weather.temperature))])
                    }
                    return nil
                }
                
            }
            
            struct City: Decodable {
                var name: String
                var country: String
            }
            
            struct MainInfo: Decodable {
                var weather: [SubWeather]
                var main: Main
            }

            struct SubWeather: Decodable {
                var description: String?
            }

            struct Main: Decodable {
                var temp: Double?
            }
        }
        
        struct ViewModel {
        }
        
    }
}
