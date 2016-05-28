//
//  RailLine.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/26/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import UIKit

class RailLine {
    
    private(set) var lineCode: String
    private(set) var displayName: String
    private(set) var startStationCode: String
    private(set) var endStationCode: String
    
    init(lineCode: String, displayName: String, startStationCode: String, endStationCode: String) {
        self.lineCode = lineCode
        self.displayName = displayName
        self.startStationCode = startStationCode
        self.endStationCode = endStationCode
    }
    
    func getColor() -> UIColor {
        switch displayName {
        case "Blue":
            return UIColor.flatSkyBlueColor()
        case "Green":
            return UIColor.flatMintColor()
        case "Orange":
            return UIColor.flatOrangeColor()
        case "Red":
            return UIColor.flatRedColor()
        case "Silver":
            return UIColor.flatWhiteColorDark()
        case "Yellow":
            return UIColor.flatYellowColor()
        default:
            return UIColor.clearColor()
        }
    }
    
}
