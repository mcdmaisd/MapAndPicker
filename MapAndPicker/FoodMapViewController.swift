//
//  FoodMapViewController.swift
//  MapAndPicker
//
//  Created by ilim on 2025-01-08.
//

import UIKit
import MapKit

class FoodMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    private let list = RestaurantList().restaurantArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapview()
    }
    
    @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
        for item in list {
            configureMenu(item)
        }
    }
    
    private func configureMenu(_ item: Restaurant) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: Constants.cancel, style: .cancel)
        let categorySet = Set(list.map { $0.category} )
        
        var categoryList = Array(categorySet).sorted()
        categoryList.append(Constants.all)
        
        for category in categoryList {
            let action = UIAlertAction(title: category, style: .default) { action in
                self.makeAnnotations(category)
            }
            alert.addAction(action)
        }
        
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func makeAnnotations(_ category: String) {
        var annotations: [MKAnnotation] = []
        
        for item in list {
            let annotation = MKPointAnnotation()
            if category == Constants.all || item.category == category {
                let coordinate = CLLocationCoordinate2D(latitude: item.latitude, longitude: item.longitude)
                annotation.coordinate = coordinate
                annotation.title = item.name
                annotations.append(annotation)
            }
        }
        
        if mapView.annotations.count != 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        
        mapView.addAnnotations(annotations)
        configureRegion()
    }
    
    private func configureRegion() {
        if let lastAnnotation = mapView.annotations.last {
            let region = MKCoordinateRegion(center: lastAnnotation.coordinate, latitudinalMeters: 400, longitudinalMeters: 400)
            mapView.setRegion(region, animated: true)
        }
    }
    
    private func configureMapview() {
        mapView.delegate = self
        makeAnnotations(Constants.all)
    }
}
