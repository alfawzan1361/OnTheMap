//
//  FindLocationViewController.swift
//  On The Map
//
//  Created by AF on 10/6/19.
//  Copyright © 2019 amaf. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class FindLocationViewController: UIViewController {

    @IBOutlet weak var mapViewOutlet: MKMapView!
        
    var location: StudentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapViewOutlet.delegate = self
        showLocations()
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        Parse.sharedInstance().postStudentLocation (self.location!) { (success, err)  in
            guard err == nil else {
                let alert = UIAlertController(title: "Erorr", message: "not find the location", preferredStyle: .alert )
                    alert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                }))
                self.present(alert, animated: true, completion: nil)
                        return
                }
            if success {
                DispatchQueue.main.async {
                    if let Controller = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") {
                        self.present(Controller, animated: true, completion: nil)}
                }
            }else{
                let alert = UIAlertController(title: "Erorr", message: "error in post location", preferredStyle: .alert )
                    alert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
    }
    
    private func showLocations() {
        guard let location = location else { return }
        let latitude = CLLocationDegrees(location.latitude!)
        let longitude = CLLocationDegrees(location.longitude!)
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = location.mapString
        annotation.subtitle = location.mediaURL
        mapViewOutlet.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapViewOutlet.setRegion(region, animated: true)
        
    }
}

extension FindLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle!,
                let url = URL(string: toOpen), app.canOpenURL(url) {
                app.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

