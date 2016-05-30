//
//  RailStationDetailsViewController.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/30/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import UIKit

class RailStationDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellId = "cell"
    @IBOutlet var RailArrivalTableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        return cell
    }
}
    