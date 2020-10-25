//
//  UserLoginInteractor.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 17.10.20.
//

import UIKit

protocol UserLoginBusinessLogic {
    func textFieldsCheck(request: UserLogin.CheckFields.Request)
}

protocol UserLoginDataStore {
}

class UserLoginInteractor: UserLoginBusinessLogic, UserLoginDataStore {
    
    var presenter: UserLoginPresentationLogic?
    private var worker: UserLoginWorker?
    
    // MARK: Check text fields
    
    func textFieldsCheck(request: UserLogin.CheckFields.Request) {
        worker = UserLoginWorker()
        worker?.doSomeWork()
        
        var response = UserLogin.CheckFields.Response(status: false)
        
        guard let userName = request.userName,
              let userMail = request.userMail,
              let userPassword = request.userPassword else { return }
        
        if !userName.isEmpty && !userMail.isEmpty && !userPassword.isEmpty {
            response = UserLogin.CheckFields.Response(status: true)
        }
        
        presenter?.presentButtonStatus(response: response)
    }
    
}
