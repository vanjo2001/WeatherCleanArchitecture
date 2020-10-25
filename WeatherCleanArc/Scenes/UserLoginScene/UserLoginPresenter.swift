//
//  UserLoginPresenter.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 17.10.20.
//

import UIKit

protocol UserLoginPresentationLogic {
    func presentButtonStatus(response: UserLogin.CheckFields.Response)
}

class UserLoginPresenter: UserLoginPresentationLogic {
    weak var viewController: UserLoginDisplayLogic?
    
    // MARK: Present button status
    
    func presentButtonStatus(response: UserLogin.CheckFields.Response) {
        let viewModel = UserLogin.CheckFields.ViewModel(status: response.status)
        viewController?.reflectLoginStatus(viewModel: viewModel)
    }
}
