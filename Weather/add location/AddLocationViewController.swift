//
//  AddLocationViewController.swift
//  Weather
//
//  Created by Ali Goktas on 20.05.2019.
//  Copyright © 2019 adesso. All rights reserved.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        self.title = "Lokasyon Ekleme"
        addMarkersToMapFromCoreData()
    }
    
    func addMarkersToMapFromCoreData() {
        let favoritesList = PersistentService.fetchAll
        for i in favoritesList {
            addMarkerToMap(latitude: i.latitude, longitude: i.longitude)
        }
    }
    
    @IBAction func PointLongPressed(_ sender: UILongPressGestureRecognizer) {
        mapView.showsUserLocation = true
        let touchPoint = sender.location(in: mapView)
        let coord: CLLocationCoordinate2D = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        addMarkerToMap(latitude: coord.latitude, longitude: coord.longitude)
        let dialogMessage = UIAlertController(title: "Favoriler", message: "Bu lokasyonu eklemek istediğinize emin misiniz?", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Evet", style: .default, handler: { (action) -> Void in
            PersistentService.addEntityToCoreData(latitude: coord.latitude, longitude: coord.longitude)
        })
        let actionCancel = UIAlertAction(title: "Hayır", style: .cancel) { (action) -> Void in
            self.removeMarkerFromMap(coord: coord)
        }
        dialogMessage.addAction(actionOk)
        dialogMessage.addAction(actionCancel)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func addMarkerToMap(latitude: Double, longitude: Double) {
        let annotation = MKPointAnnotation()
        let coord = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.coordinate = coord
        annotation.subtitle = "\(round(1000*coord.longitude)/1000), \(round(1000*coord.latitude)/1000)"
        mapView.addAnnotation(annotation)
    }
    
    func removeMarkerFromMap(coord: CLLocationCoordinate2D) {
        let allAnnotations = self.mapView.annotations
        for eachAnnotation in allAnnotations {
            if eachAnnotation.coordinate.latitude == coord.latitude || eachAnnotation.coordinate.longitude == coord.longitude{
                self.mapView.removeAnnotation(eachAnnotation)
            }
        }
    }
    
}
