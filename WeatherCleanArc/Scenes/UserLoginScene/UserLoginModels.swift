//
//  UserLoginModels.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 17.10.20.
//

import UIKit

enum UserLogin {
    // MARK: Use cases
    
    enum CheckFields {
        
        struct Request {
            let userName: String?
            let userMail: String?
            let userPassword: String?
        }
        
        struct Response {
            let status: Bool
        }
        
        struct ViewModel {
            let status: Bool
        }
        
    }
}
