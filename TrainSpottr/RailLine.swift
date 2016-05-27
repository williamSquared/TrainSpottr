//
//  RailLine.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/26/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import UIKit

class RailLine {
    
    private var lineCode: String
    private var displayName: String
    private var startStationCode: String
    private var endStationCode: String
    
    init(lineCode: String, displayName: String, startStationCode: String, endStationCode: String) {
        self.lineCode = lineCode
        self.displayName = displayName
        self.startStationCode = startStationCode
        self.endStationCode = endStationCode
    }
}
