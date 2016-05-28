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
    
    // MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableViewRows()
    }
    
    // MARK: TableView Methods
    func configureTableViewRows() {
        tableView.rowHeight = 100
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) 
        
        return cell
    }
}
