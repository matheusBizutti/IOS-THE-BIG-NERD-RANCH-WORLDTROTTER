//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by MATHEUS BIZUTTI on 24/04/18.
//  Copyright © 2018 T1aluno04. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    var button: UIButton!
    var locationManager = CLLocationManager.init()
    
    var wasBornPin: MKPointAnnotation!
    var locationPin: MKPointAnnotation!
    var futurePin: MKPointAnnotation!
    
    override func loadView() {
        
        // Create a map view
        mapView = MKMapView()
        
        view = mapView
        
        // - SegmentControl
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // - Constraints
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,
                                                  constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        // - Activating constraints
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
        
        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        let button = UIButton(type: .custom)
        let buttonWidth = 50
        
        button.frame = CGRect(x: 15,y: 100,width: buttonWidth, height: buttonWidth)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.borderWidth = 0.75
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.setTitle("○", for: UIControlState())
        button.setTitleColor(UIColor.darkGray, for: UIControlState())
        button.addTarget(self, action: #selector(MapViewController.setLocation(_:)), for: .touchUpInside)
        
        view.addSubview(button)
        
        // - PINS:
        // - LocationPin
        let appleAcademyPin = GeneratePin(
            title: "Apple Academy",
            location: "Eldorado Institute",
            discipline: "",
            coordinate: CLLocationCoordinate2D(latitude: -22.813316504815599, longitude: -47.061342331064559)
        )
        
         mapView.addAnnotation(appleAcademyPin)
        
        let paraguayPin = GeneratePin(
            title: "Paraguay",
            location: "Paraguay",
            discipline: "",
            coordinate: CLLocationCoordinate2D(latitude: -23.499921412842955, longitude: -58.44835039999998)
        )
        
        mapView.addAnnotation(paraguayPin)

        let locationPin = GeneratePin(
            title: "Location",
            location: "My location",
            discipline: "",
            coordinate: locationManager.location!.coordinate
        )

        mapView.addAnnotation(locationPin)
        
    }

    // - Functions
    // - @extends objective C - @objc
   @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
    
        switch segControl.selectedSegmentIndex {
            case 0:
                mapView.mapType = .standard
            case 1:
                mapView.mapType = .hybrid
            case 2:
                mapView.mapType = .satellite
            default:
                break
        }
    }
    
    @objc func setLocation(_ sender: UIButton!) {
        let span = MKCoordinateSpan.init(latitudeDelta: 0.0075, longitudeDelta: 0.0075)
        if locationManager.location != nil {
            let region = MKCoordinateRegion.init(center: (locationManager.location?.coordinate)!, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
}

// - Extensions:
extension MapViewController {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? GeneratePin else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! GeneratePin
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
}


