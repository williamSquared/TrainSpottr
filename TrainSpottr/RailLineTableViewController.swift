//
//  RailLineTableViewController.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/26/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//

import UIKit
import ChameleonFramework

class RailLineTableViewController: UITableViewController {
    
    // MARK: Class Variables
    private let cellId = "cell"
    private var railLines = [RailLine]()
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRailLines()
        configureTableViewRows()
    }
    
    // MARK: Network Call
    func getRailLines() {
        WMATAService.getRailLines(){ (result) -> Void in
            if result != nil {
                self.railLines = result as! [RailLine]
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: TableView Methods
    func configureTableViewRows() {
        tableView.rowHeight = view.frame.height / 6.75
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return railLines.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> RailLineCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! RailLineCell
        
        cell.railLineDisplayName.text = "\(railLines[indexPath.row].displayName)"
        cell.backgroundColor = railLines[indexPath.row].getColor()
        return cell
    }
}
