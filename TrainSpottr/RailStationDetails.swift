//
//  RailStationDetails.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/30/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import UIKit

class RailStationDetails {
    
    private(set) var numOfCars: String
    private(set) var destination: String
    private(set) var etaInMinutes: String
    
    init(numOfCars: String, destination: String, etaInMinutes: String) {
        self.numOfCars = numOfCars
        self.destination = destination
        self.etaInMinutes = etaInMinutes
    }
}
