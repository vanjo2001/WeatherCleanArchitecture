//
//  UserLoginConfigurator.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 20.10.20.
//

import UIKit

final class UserLoginConfigurator {
    static let shared = UserLoginConfigurator()
    
    private init() {}
    
    func configurate(_ controller: UserLoginViewController) {
        let viewController = controller
        let interactor = UserLoginInteractor()
        let presenter = UserLoginPresenter()
        let router = UserLoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
