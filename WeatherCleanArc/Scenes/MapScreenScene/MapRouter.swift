//
//  MapRouter.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 24.10.20.
//

import UIKit

@objc protocol MapRoutingLogic {
    func routeToMainScreen(segue: UIStoryboardSegue?)
    func popBack()
}

protocol MapDataPassing {
    var dataStore: MapDataStore? { get set }
}

class MapRouter: NSObject, MapRoutingLogic, MapDataPassing {
    
    weak var viewController: MapViewController?
    var dataStore: MapDataStore?
    var weatherByCoordinate: MainScreen.DefaultListOfCities.ViewModel?
    
//    MARK: Routing
    
    func routeToMainScreen(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! MainScreenViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToMainScreen(source: dataStore!, destination: &destinationDS)
        } else {

            let index = viewController!.navigationController!.viewControllers.count - 2
            let destinationVC = viewController?.navigationController?.viewControllers[index] as! MainScreenViewController
            
            var destinationDS = destinationVC.router!.dataStore!
            passDataToMainScreen(source: dataStore!, destination: &destinationDS)
            navigateToMainScreen(source: viewController!, destination: destinationVC)
        }
    }
    
    func popBack() {
        
    }
    
//    MARK: Navigation
    
    func navigateToMainScreen(source: MapViewController, destination: MainScreenViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
//    MARK: Passing data
    
    func passDataToMainScreen(source: MapDataStore, destination: inout MainScreenDataStore) {
        destination.coordinate = source.coordinate
    }
}
