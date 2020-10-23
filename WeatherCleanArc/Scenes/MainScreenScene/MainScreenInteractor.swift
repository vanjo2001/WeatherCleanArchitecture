//
//  MainScreenInteractor.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 18.10.20.
//

import UIKit

protocol MainScreenBusinessLogic {
    func selectRow(request: MainScreen.DefaultListOfCities.Request)
}

protocol MainScreenDataStore {
    //var name: String { get set }
}

class MainScreenInteractor: MainScreenBusinessLogic, MainScreenDataStore {
    var presenter: MainScreenPresentationLogic?
    var worker: MainScreenWorker?
    
    //var name: String = ""
    
    
    // MARK: Do something
    
    func selectRow(request: MainScreen.DefaultListOfCities.Request) {
        worker = MainScreenWorker()
        worker?.networkService = NetworkService()
        
        var cities: [MainScreen.DefaultListOfCities.CityInfo]!
        
        cities = worker?.loadJSONFromFile(fileName: "data", extensionOfFile: "json")
        
        LimitService.shared.loadDataIfNeeded(refreshTime: 1, keyIndex: String(request.indexRow)) { (status) in
            if status {
                
                let current = cities[request.indexRow]
                worker?.networkService.city = current.city
                
                var response = packResponse(request: request, cities: cities, loadedWeather: nil)
                
                self.worker?.execute(city: current.city, id: Int64(request.indexRow)) { data in
                    
                    LimitService.shared.addLimit(keyIndex: String(request.indexRow))
                    
                    switch (data) {
                    case .success(let str):
                        response.fullInfo.append(str)
                        self.presenter?.presentSomething(response: response)
                    case .failure(let error):
                        response.fullInfo.append(error.localizedDescription)
                        self.presenter?.presentSomething(response: response)
                    }
                }
                
                
                self.presenter?.presentSomething(response: response)
            } else {
                let weather = Weather.convert(weather: worker?.fineBy(predicate: "weatherId == \(request.indexRow)"))
                
                presenter?.presentSomething(response: packResponse(request: request, cities: cities, loadedWeather: weather))
                
                print("load from core data or something)")
            }
        }
    }
    
    func packResponse(request: MainScreen.DefaultListOfCities.Request,
                      cities: [MainScreen.DefaultListOfCities.CityInfo],
                      loadedWeather: Weather?) -> MainScreen.DefaultListOfCities.Response {
        
        let current = cities[request.indexRow]
        let fullInfo = "City: \(current.city)\nDescription: \(current.description)\nCountry code: \(current.code)"
        
        var response = MainScreen.DefaultListOfCities.Response(cities: cities, fullInfo: fullInfo)
        if let loaded = loadedWeather {
            response.fullInfo += loaded.fullInfo
        }
        return response
    }
    

}
