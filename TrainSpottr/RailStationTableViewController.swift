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
    internal var lineCode: String?
    internal var color: UIColor?
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableViewRows()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        getRailStations(lineCode: lineCode!)
        navigationController?.navigationBar.barTintColor = color
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        navigationController!.navigationBar.tintColor = UIColor.whiteColor();
    }
    
    // MARK: Network Call
    private func getRailStations(lineCode lineCode: String) {
        WMATAService.getRailStations(lineCode: lineCode){ (result) -> Void in
            if result != nil {
                self.railStations = result as! [RailStation]
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
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
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! RailStationCell
        
        let railStation = railStations[indexPath.row]
        cell.stationName.text = "\(railStation.name)"
        cell.addressLineOne.text = "\(railStation.street)"
        cell.addressLineTwo.text = "\(railStation.city), \(railStation.state) \(railStation.zip)"
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "RaillStationToRailStationDetails") {
            let railStationDetailsViewController: RailStationDetailsViewController = segue.destinationViewController as! RailStationDetailsViewController
            
            let railStation = railStations[(tableView.indexPathForSelectedRow?.row)!]
            railStationDetailsViewController.stationName = railStation.name
            railStationDetailsViewController.stationCode = railStation.stationCode
        }
    }
}
