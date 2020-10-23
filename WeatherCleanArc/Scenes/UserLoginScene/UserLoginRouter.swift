//
//  UserLoginRouter.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 17.10.20.
//

import UIKit

@objc protocol UserLoginRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol UserLoginDataPassing {
    var dataStore: UserLoginDataStore? { get }
}

class UserLoginRouter: NSObject, UserLoginRoutingLogic, UserLoginDataPassing {
    weak var viewController: UserLoginViewController?
    var dataStore: UserLoginDataStore?
    
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
    
    //func navigateToSomewhere(source: UserLoginViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: UserLoginDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
