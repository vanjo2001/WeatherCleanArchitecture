//
//  TextField.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 23.10.20.
//

import UIKit

extension UserLoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
