//
//  WMATAService.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/26/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import Foundation

enum Path: String {
    case RailLines = "Rail.svc/json/jLines/"
    case RailStations = "Rail.svc/json/jStations"
    case RailStationDetails = "StationPrediction.svc/json/GetPrediction/"
}

class WMATAService {
    
    // MARK: Private Variables
    private static let baseURLString = "https://api.wmata.com/"
    private static let pList = NSBundle.mainBundle().pathForResource("keys", ofType: "plist")
    private static let plistContents = NSDictionary(contentsOfFile: pList!) as! [String: AnyObject]
    
    // MARK: Public Class Functions
    /*
     Check WMATA for rail lines. For all existing lines, create a RailLine (model).
     Returns a collection of RailLine's
     */
    class func getRailLines(completion completion: ((result: NSArray?) -> Void)!) {
        let url = wmataURL(path: .RailLines, parameters: nil, pathParameter: nil)
        _ = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    completion(result: processRailLines(json: jsonResult))
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            }.resume()
    }
    
    /*
     Check WMATA for rail stations. For all existing stations, create a RailStation (model).
     Returns a collection of RailStation's
     */
    class func getRailStations(lineCode lineCode: String, completion: ((result: NSArray?) -> Void)!) {
        let url = wmataURL(path: .RailStations, parameters: ["LineCode": lineCode], pathParameter: nil)
        _ = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    completion(result: processRailStations(json: jsonResult))
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    /*
     Check WMATA for predicted train arrivals. Returns a collection of Trains
     */
    class func getRailStationDetails(stationCode stationCode: String, completion: ((result: NSArray?) -> Void)!) {
        var baseUrl = baseURLString
        baseUrl.appendContentsOf(stationCode)
        let url = wmataURL(path: .RailStationDetails, parameters: nil, pathParameter: stationCode)
        _ = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    completion(result: processTrainDetails(json: jsonResult))
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    /*
     Input: enum Path
     Output: WMATA NSURL for use by network calls e.g. NSURLSession
    */
    private class func wmataURL(path path: Path, parameters: [String:String]?, pathParameter: String?) -> NSURL {
        
        var url = baseURLString.stringByAppendingString(path.rawValue)
        if let pathParam = pathParameter {
            url = url.stringByAppendingString(pathParam)
        }
        
        let components = NSURLComponents(string: url)
        var queryItems = [NSURLQueryItem]()
        
        let APIKey = String(plistContents["WmataAPIKey"]!)
        let baseParams = [
            "api_key": APIKey
        ]
        
        for(key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components!.queryItems = queryItems
        return components!.URL!
    }
    
    // MARK: Private Class Helper Functions
    private class func processRailLines(json json: NSDictionary) -> [RailLine] {
        var railLines: [RailLine] = []
        
        for line in json["Lines"] as! [AnyObject]{
            let lineCode = line["LineCode"]!!.description
            let displayName = line["DisplayName"]!!.description
            let startStationCode = line["StartStationCode"]!!.description
            let endStationCode = line["EndStationCode"]!!.description
            
            let railLine = RailLine(lineCode: lineCode, displayName: displayName, startStationCode: startStationCode, endStationCode: endStationCode)
            
            railLines.append(railLine)
        }
        
        return railLines
    }
    
    private class func processRailStations(json json: NSDictionary) -> [RailStation]{
        var railStations: [RailStation] = []
        
        for station in json["Stations"] as! [AnyObject]{
            let name = station["Name"]!!.description
            let street = station["Address"]!!["Street"]!!.description
            let city = station["Address"]!!["City"]!!.description
            let state = station["Address"]!!["State"]!!.description
            let zip = station["Address"]!!["Zip"]!!.description
            let stationCode = station["Code"]!!.description
            
            let railStation = RailStation(name: name, street: street, city: city, state: state, zip: zip, stationCode: stationCode)
            
            railStations.append(railStation)
        }
        
        return railStations
    }
    
    private class func processTrainDetails(json json: NSDictionary) -> [Train] {
        var trains: [Train] = []
        
        for trainDetails in json["Trains"] as! [AnyObject]{
            let destination = trainDetails["DestinationName"]!!.description
            let etaInMinutes = trainDetails["Min"]!!.description
            
            if destination != "Train" || etaInMinutes == nil {
                let numOfCars = trainDetails["Car"]!!.description
                let train = Train(numOfCars: numOfCars, destination: destination, etaInMinutes: etaInMinutes)
                
                trains.append(train)
            }
        }
        
        return trains
    }
}
