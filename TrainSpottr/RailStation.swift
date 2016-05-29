//
//  RailStation.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/28/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import UIKit

class RailStation {
    
    private(set) var name: String
    private(set) var street: String
    private(set) var city: String
    private(set) var state: String
    private(set) var zip: String
    
    init(name: String, street: String, city: String, state: String, zip: String) {
        self.name = name
        self.street = street
        self.city = city
        self.state = state
        self.zip = zip
    }
}