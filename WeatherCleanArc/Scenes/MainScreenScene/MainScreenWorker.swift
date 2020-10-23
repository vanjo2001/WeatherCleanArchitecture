//
//  MainScreenWorker.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 18.10.20.
//

import UIKit
import CoreData

final class MainScreenWorker {
    
    var networkService: NetworkServiceProtocol!
    private var weatherData: [WeatherEntity] = []
    
    
    func execute(city: String, id: Int64, complitionHandler: @escaping (Result<String, Error>) -> ()) {
        networkService.getJSONData(city) { (result) in
            switch result {
            case .success(var weather):
                weather.id = id
                self.createUpdateWeather(weather)
                complitionHandler(.success(weather.fullInfo))
            case .failure(let error):
                complitionHandler(.failure(error))
            }
        }
    }
    
    func loadJSONFromFile(fileName: String, extensionOfFile: String) -> [MainScreen.DefaultListOfCities.CityInfo] {
        var cities: [MainScreen.DefaultListOfCities.CityInfo] = []
        if let pathToJSONFile = Bundle.main.url(forResource: fileName, withExtension: extensionOfFile) {
            do {
                let data = try Data(contentsOf: pathToJSONFile)
                let decoder = JSONDecoder()
                cities = try decoder.decode([MainScreen.DefaultListOfCities.CityInfo].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return cities
    }
    
    
    //MARK: - CoreData
    private func createUpdateWeather(_ input: Weather) {
        
        let finded = fineBy(predicate: "weatherId == \(input.id)")
        
        if let finded = finded {
            finded.weatherId = input.id
            finded.temperature = input.list.first?.main.temp ?? 0.0
            finded.weatherDescription = input.list.first?.weather.first?.description
            saveWeather()
            return
        }
        
        let data = WeatherEntity(context: PersistenceService.context)
        data.weatherId = input.id
        data.temperature = input.list.first?.main.temp ?? 0.0
        data.weatherDescription = input.list.first?.weather.first?.description
        saveWeather()
    }
    
    private func saveWeather() {
        PersistenceService.saveContext()
    }
    
    
    func fineBy(predicate: String?) -> WeatherEntity? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherEntity")
        var result: WeatherEntity?
        if let predicate = predicate {
            fetchRequest.predicate = NSPredicate(format: predicate)
        }
        
        do {
            let data = try PersistenceService.context.fetch(fetchRequest)
            result = data.first as! WeatherEntity?
            
            return result
        } catch {
            print(error.localizedDescription)
        }
        
        return result
        
    }
    
    
//    private func deleteWeather() {
//
//        allData = []
//        let managedContext = PersistenceService.context
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "")
//
//        do {
//            let test = try managedContext.fetch(fetchRequest)
//
//            let objectToDelete = test as! [NSManagedObject]
//            for one in objectToDelete {
//                managedContext.delete(one)
//            }
//
//            do {
//                try managedContext.save()
//            } catch {
//                print(error)
//            }
//
//        } catch {
//            print(error)
//        }
//    }

}
