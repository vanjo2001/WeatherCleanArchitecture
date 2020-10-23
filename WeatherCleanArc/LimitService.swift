//
//  LimitService.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 22.10.20.
//

import Foundation

protocol LimitProtocol {
    func loadDataIfNeeded(refreshTime perHour: Int, keyIndex: String, completion: (Bool) -> ())
}


class LimitService: LimitProtocol {
    
    static let shared = LimitService()
    private init() {}
    
    private let defaults = UserDefaults.standard
    private var defaultsKey = "lastRefresh"
    private let calender = Calendar.current
    
    func loadDataIfNeeded(refreshTime perHour: Int, keyIndex: String, completion: (Bool) -> ()) {
        
        if isRefreshRequired(refreshTime: perHour, keyIndex: keyIndex) {
            // load the data
            
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func addLimit(keyIndex: String) {
        defaults.set(Date(), forKey: defaultsKey + keyIndex)
    }
    
    private func isRefreshRequired(refreshTime: Int, keyIndex: String) -> Bool {
        
        guard let lastRefreshDate = defaults.object(forKey: defaultsKey + keyIndex) as? Date else {
            return true
        }
        
        if let diff = calender.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour, diff > refreshTime {
            return true
        } else {
            return false
        }
    }
}
