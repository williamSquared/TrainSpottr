//
//  RailStationTableViewController.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/28/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import UIKit

class RailStationTableViewController: UITableViewController {
    // MARK: Class Variables
    private let cellId = "cell"
    private var railStations = [RailStation]()
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRailStations(lineCode: "SV")
        configureTableViewRows()
    }
    
    // MARK: Network Call
    func getRailStations(lineCode lineCode: String) {
        WMATAService.getRailStations(lineCode: lineCode){ (result) -> Void in
            if result != nil {
                self.railStations = result as! [RailStation]
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
                print("\(result)")
            }
        }
    }
    
    // MARK: TableView Methods
    func configureTableViewRows() {
        tableView.rowHeight = 100
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.railStations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) 
        
        return cell
    }
}
