//
//  MapPresenter.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 24.10.20.
//

import UIKit

protocol MapPresentationLogic {
    func presentSomething(response: Map.FetchWeatherByCoordinate.Response)
}

class MapPresenter: MapPresentationLogic {
    weak var viewController: MapDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: Map.FetchWeatherByCoordinate.Response) {
    }
}
