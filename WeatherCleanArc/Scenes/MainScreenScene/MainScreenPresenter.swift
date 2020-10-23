//
//  MainScreenPresenter.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 18.10.20.
//

import UIKit

protocol MainScreenPresentationLogic {
    func presentSomething(response: MainScreen.DefaultListOfCities.Response)
}

class MainScreenPresenter: MainScreenPresentationLogic {
    weak var viewController: MainScreenDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: MainScreen.DefaultListOfCities.Response) {
        let viewModel = MainScreen.DefaultListOfCities.ViewModel(cities: response.cities, fullInfo: response.fullInfo)
        viewController?.displaySomething(viewModel: viewModel)
    }
}
