//
//  StudentLocation.swift
//  On The Map
//
//  Created by AF on 10/6/19.
//  Copyright © 2019 amaf. All rights reserved.
//

import Foundation
import UIKit

struct StudentLocation : Codable {
    
    static var Location = [StudentLocation]()
    
    var createdAt : String?
    var firstName : String?
    var lastName : String?
    var latitude : Double?
    var longitude : Double?
    var mapString : String?
    var mediaURL : String?
    var objectId : String?
    var uniqueKey : String?
    var updatedAt : String?
    
}
extension StudentLocation {
    init(mapString: String, mediaURL: String) {
        self.mapString = mapString
        self.mediaURL = mediaURL
    }
}

