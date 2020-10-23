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
        }
        
        struct Response: Decodable {
            var cities: [CityInfo]
            var fullInfo: String
        }
        
        struct ViewModel: Decodable {
            var cities: [CityInfo]
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
            var city: String
        }
        
        struct Response {
            var weather: Weather
            
            struct Weather: Decodable {
                var id: Int64 = 0
                var cod: String?
                var message: Int?
                var list: [MainInfo]
                
                var fullInfo: String {
                    return "\n\nTemperature equal: \(list.first?.main.temp ?? -1)\n\nDescription: \(list.first?.weather.first?.description ?? "nil")"
                }
                
                private enum CodingKeys: String, CodingKey {
                    case cod, message, list
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
