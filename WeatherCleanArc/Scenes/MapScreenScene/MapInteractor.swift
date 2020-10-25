//
//  MapInteractor.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 24.10.20.
//

import UIKit
import CoreLocation

protocol MapBusinessLogic {
}

protocol MapDataStore {
    var coordinate: CLLocationCoordinate2D { get set }
}

class MapInteractor: MapBusinessLogic, MapDataStore {
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var presenter: MapPresentationLogic?
    
    // MARK: Do something
    
}
