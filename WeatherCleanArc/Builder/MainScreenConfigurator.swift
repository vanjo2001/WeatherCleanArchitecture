//
//  MainScreenConfigurator.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 20.10.20.
//

import UIKit

final class MainScreenConfigurator {
    static let shared = MainScreenConfigurator()
    
    private init() {}
    
    func configurate(_ controller: MainScreenViewController) {
        let viewController = controller
        let interactor = MainScreenInteractor()
        let presenter = MainScreenPresenter()
        let router = MainScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
