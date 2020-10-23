//
//  DoubleExt.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 19.10.20.
//

import Foundation

extension Double {
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
