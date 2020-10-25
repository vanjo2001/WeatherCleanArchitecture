//
//  MapConfigurator.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 24.10.20.
//

import UIKit

final class MapConfigurator {
    static let shared = MapConfigurator()
    
    private init() {}
    
    func configurate(_ controller: MapViewController) {
        let viewController = controller
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
