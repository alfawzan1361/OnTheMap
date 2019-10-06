//
//  AddLocationViewController.swift
//  On The Map
//
//  Created by AF on 10/6/19.
//  Copyright © 2019 amaf. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class AddLocationViewController: UIViewController {

    @IBOutlet weak var locationText: UITextField!
    @IBOutlet weak var URLText: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func findButton(_ sender: Any) {
        guard let location = locationText.text, let url = URLText.text,
                location != "", url != "" else {
                    let alert = UIAlertController(title: "Erorr", message: "Please enter Location and URL", preferredStyle: .alert )
                    alert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(alert, animated: true, completion: nil)
                    return
            }
            let studentLocation = StudentLocation(mapString: location, mediaURL: url)
            findLocation(studentLocation)
        }
        
    func findLocation(_ search: StudentLocation){
        CLGeocoder().geocodeAddressString(search.mapString!) { (placemarks, error) in
            guard let firstLocation = placemarks?.first?.location else {
                let alert = UIAlertController(title: "Erorr", message: "Location not found", preferredStyle: .alert )
                alert.addAction(UIAlertAction (title: "OK", style: .default, handler: { _ in
                    return
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
            var location = search
            location.latitude = firstLocation.coordinate.latitude
            location.longitude = firstLocation.coordinate.longitude
            self.performSegue(withIdentifier: "location", sender: location)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "location", let vc = segue.destination as? FindLocationViewController {
            vc.location = (sender as! StudentLocation)
        }
    }
}

