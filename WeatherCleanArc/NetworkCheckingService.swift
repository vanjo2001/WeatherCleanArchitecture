//
//  NetworkCheckingService.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 27.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Network

class NetworkCheckingService {
    static func monitorChecking(completionHandler: @escaping (NWPath.Status) -> ()) {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "com.vanjo")
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                // if isn't connected
                completionHandler(.satisfied)
            } else {
                // if successfully connected
                completionHandler(.unsatisfied)
            }
        }
        
        monitor.start(queue: queue)
    }
    
}
