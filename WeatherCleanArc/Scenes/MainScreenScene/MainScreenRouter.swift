//
//  MainScreenRouter.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 18.10.20.
//

import UIKit

@objc protocol MainScreenRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MainScreenDataPassing {
    var dataStore: MainScreenDataStore? { get }
}

class MainScreenRouter: NSObject, MainScreenRoutingLogic, MainScreenDataPassing {
    weak var viewController: MainScreenViewController?
    var dataStore: MainScreenDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: MainScreenViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: MainScreenDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
