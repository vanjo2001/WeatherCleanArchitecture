//
//  MainScreenPresenter.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 18.10.20.
//

import UIKit

protocol MainScreenPresentationLogic {
    func presentWeatherByCoordinate(response: MainScreen.FetchWeather.Response)
    func presentWeatherInfo(response: MainScreen.DefaultListOfCities.Response)
}

class MainScreenPresenter: MainScreenPresentationLogic {
    
    weak var viewController: MainScreenDisplayLogic?
    
    // MARK: Do something
    
    func presentWeatherInfo(response: MainScreen.DefaultListOfCities.Response) {
        
        guard let current = response.currentCity else { return }
        
        var fullInfo = "City: \(current.city)\nDescription: \(current.description)\nCountry code: \(current.code)"
        
        if let weather = response.weather {
            fullInfo.append("\n\nTemperature equal: \(Int(weather.list.first?.main.temp ?? 0))\n\nDescription: \(weather.list.first?.weather.first?.description ?? "nil")")
        }
        
        let viewModel = MainScreen.DefaultListOfCities.ViewModel(cities: response.cities, fullInfo: fullInfo)
        
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    func presentWeatherByCoordinate(response: MainScreen.FetchWeather.Response) {
        let cityInfo = MainScreen.DefaultListOfCities.CityInfo(city: response.weatherByCity.city?.name ?? "none",
                                                               code: response.weatherByCity.city?.country ?? "none",
                                                               description: "country from map")
        
        let viewModel = MainScreen.DefaultListOfCities.ViewModel(cities: [cityInfo], fullInfo: "full info")
        viewController?.displayWeatherByCoordinate(viewModel: viewModel)
    }
}
