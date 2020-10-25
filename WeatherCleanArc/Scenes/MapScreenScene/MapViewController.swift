//
//  MapViewController.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 24.10.20.
//

import UIKit
import MapKit

protocol MapDisplayLogic: class {
}

final class MapViewController: UIViewController, MapDisplayLogic {
    var interactor: MapBusinessLogic?
    var router: (NSObjectProtocol & MapRoutingLogic & MapDataPassing)?
    
    @IBOutlet weak var mapView: MKMapView!
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        MapConfigurator.shared.configurate(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        MapConfigurator.shared.configurate(self)
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateGesture()
    }
    
    func configurateGesture() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gesture:)))
        mapView.delegate = self
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func handleTap(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
//
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        annotation.title = "Target"
//        mapView.addAnnotation(annotation)
        
        
        router?.dataStore?.coordinate = coordinate
        router?.routeToMainScreen(segue: nil)
    }
    
}


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("selected")
        
    }
    
}
