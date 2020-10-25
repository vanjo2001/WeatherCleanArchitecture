//
//  MapModels.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 24.10.20.
//

import UIKit
import CoreLocation

enum Map {
    // MARK: Use cases
    
    enum FetchWeatherByCoordinate {
        struct Request {
            let coordinate: CLLocationCoordinate2D
        }
        
        struct Response {
            let weatherByCoordinate: MainScreen.FetchWeather.Response
        }
        
        struct ViewModel {
            let weatherInfo: MainScreen.DefaultListOfCities.ViewModel
        }
        
    }
}
