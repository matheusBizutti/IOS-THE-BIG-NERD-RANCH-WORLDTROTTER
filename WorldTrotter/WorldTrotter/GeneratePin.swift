//
//  GeneratePin.swift
//  WorldTrotter
//
//  Created by MATHEUS BIZUTTI on 25/04/18.
//  Copyright © 2018 T1aluno04. All rights reserved.
//

//        // - This method should substitute code:
//        let locationPin = MKPointAnnotation()
//        locationPin.coordinate = CLLocationCoordinate2D(latitude: -22.813316504815599, longitude: -47.061342331064559)
//        locationPin.title = "Eldorado"
//        locationPin.subtitle = "Apple Academy"
//
//        mapView.addAnnotation(locationPin)
//

import MapKit
import Contacts

class GeneratePin: NSObject, MKAnnotation {
    
    let title: String?
    let location: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, location: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.location = location
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return location
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
