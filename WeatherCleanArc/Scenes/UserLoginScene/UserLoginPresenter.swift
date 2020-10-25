//
//  UserLoginPresenter.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 17.10.20.
//

import UIKit

protocol UserLoginPresentationLogic {
    func presentSomething(response: UserLogin.CheckFields.Response)
}

class UserLoginPresenter: UserLoginPresentationLogic {
    weak var viewController: UserLoginDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: UserLogin.CheckFields.Response) {
        let viewModel = UserLogin.CheckFields.ViewModel(status: response.status)
        viewController?.reflectLoginStatus(viewModel: viewModel)
    }
}
