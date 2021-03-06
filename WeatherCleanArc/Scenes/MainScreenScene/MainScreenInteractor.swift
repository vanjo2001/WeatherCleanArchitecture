//
//  MainScreenInteractor.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 18.10.20.
//

import UIKit
import MapKit

protocol MainScreenBusinessLogic {
    func selectRow(request: MainScreen.DefaultListOfCities.Request)
}

protocol MainScreenDataStore {
    var coordinate: CLLocationCoordinate2D? { get set }
    var cities: [MainScreen.DefaultListOfCities.CityInfo]? { get set }
}

class MainScreenInteractor: MainScreenBusinessLogic, MainScreenDataStore {
    
    var cities: [MainScreen.DefaultListOfCities.CityInfo]?
    
    
    var coordinate: CLLocationCoordinate2D? {
        didSet {
            getWeatherByCoordinate()
        }
    }
    
    var presenter: MainScreenPresentationLogic?
    private var worker: MainScreenWorker?
    private var networkWorker: NetworkWorker?
    
    
    init(worker: MainScreenWorker = MainScreenWorker(), networkWorker: NetworkWorker = NetworkWorker()) {
        self.worker = worker
        self.networkWorker = networkWorker
    }
    
    // MARK: Select row
    
    func selectRow(request: MainScreen.DefaultListOfCities.Request) {
        worker = MainScreenWorker()
        networkWorker = NetworkWorker()
        
        
        //Load from file if first time
        if cities == nil {
            cities = worker?.loadJSONFromFile(fileName: "data", extensionOfFile: "json")
        }
        
        //Append city from map if exists
        if let city = request.cityByCoordinate, city.city != cities?.last?.city {
            cities?.append(city)
        }
        
        
        //Check limit
        LimitService.shared.loadDataIfNeeded(refreshTime: 1, keyIndex: String(request.indexRow)) { (status) in
            
            //Limit is not targeted
            if status {
                
                let current = cities?[request.indexRow]
                networkWorker?.networkService.way = .byCity(city: current?.city ?? "nil")
                
                var response = packResponse(request: request, cities: cities ?? [MainScreen.DefaultListOfCities.CityInfo](), loadedWeather: nil)
                
                self.networkWorker?.execute(id: Int64(request.indexRow)) { data in
                    
                    LimitService.shared.addLimit(keyIndex: String(request.indexRow))
                    
                    switch (data) {
                    case .success(var weatherWithId):
                        
                        guard let id = weatherWithId.id else { return }
                        
                        weatherWithId.weather.id = id
                        //Create or update (Core Data)
                        self.worker?.createUpdateWeather(weatherWithId.weather)
                        
                        //Response if success
                        response.weather = weatherWithId.weather
                        self.presenter?.presentWeatherInfo(response: response)
                    case .failure(let error):
                        
                        //Response if error
                        response.error = error
                        self.presenter?.presentWeatherInfo(response: response)
                    }
                }
                
                self.presenter?.presentWeatherInfo(response: response)
                
                //Limit is targeted
            } else {
                let weather = Weather.convert(weather: worker?.fineBy(predicate: "weatherId == \(request.indexRow)"))
                
                presenter?.presentWeatherInfo(response: packResponse(request: request, cities: cities ?? [MainScreen.DefaultListOfCities.CityInfo](), loadedWeather: weather))
            }
        }
    }
    
    private func getWeatherByCoordinate() {
        
        networkWorker?.networkService.way = .byCoordinate(coordinate: coordinate ?? CLLocationCoordinate2D())
        networkWorker?.execute(id: nil, complitionHandler: { result in
            switch result {
            case .success(let weatherWithId):
                self.presenter?.presentWeatherByCoordinate(response: MainScreen.FetchWeather.Response(weatherByCity: weatherWithId.weather))
            case .failure(let error):
                print(error)
            }
        })
    }
    
    
    private func packResponse(request: MainScreen.DefaultListOfCities.Request,
                      cities: [MainScreen.DefaultListOfCities.CityInfo],
                      loadedWeather: Weather?) -> MainScreen.DefaultListOfCities.Response {
        
        let current = cities[request.indexRow]
        let _ = "City: \(current.city)\nDescription: \(current.description)\nCountry code: \(current.code)"
        
        let response = MainScreen.DefaultListOfCities.Response(cities: cities, currentCity: current, weather: loadedWeather)

        return response
    }
    

}
