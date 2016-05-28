//
//  WMATAService.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/26/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import Foundation

enum Path: String {
    case RailLines = "jLines/"
}

class WMATAService {
    
    private static let baseURLString = "https://api.wmata.com/Rail.svc/json/"
    private static let pList = NSBundle.mainBundle().pathForResource("keys", ofType: "plist")
    private static let plistContents = NSDictionary(contentsOfFile: pList!) as! [String: AnyObject]
    
    /*
     Input: enum Path
     Output: WMATA NSURL for use by network calls e.g. NSURLSession
    */
    private class func wmataURL(path path: Path) -> NSURL {
        
        let url = baseURLString.stringByAppendingString(path.rawValue)
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
        
        components!.queryItems = queryItems
        return components!.URL!
    }
    
    /*
     Check WMATA for existing lines. For all existing lines, create a RailLine (model). 
     Returns a collection of RailLine's
    */
    class func getRailLines(completion completion: ((result: NSArray?) -> Void)!) {
        let url = wmataURL(path: .RailLines)
        _ = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) in
            do {
                if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    
                    var railLines: [RailLine] = []
                    
                    for (line) in jsonResult["Lines"] as! [AnyObject]{
                        let lineCode = line["LineCode"]!!.description
                        let displayName = line["DisplayName"]!!.description
                        let startStationCode = line["StartStationCode"]!!.description
                        let endStationCode = line["EndStationCode"]!!.description
                        
                        let railLine = RailLine(lineCode: lineCode, displayName: displayName, startStationCode: startStationCode, endStationCode: endStationCode)
                        
                        railLines.append(railLine)
                    }
                    completion(result: railLines)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
