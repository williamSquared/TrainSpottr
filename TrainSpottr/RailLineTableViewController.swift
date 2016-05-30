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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 255, green: 255, blue: 255, alpha: 0.90)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor()]
    }
    
    // MARK: Network Call
    private func getRailLines() {
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
        tableView.separatorStyle = .None
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return railLines.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> RailLineCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! RailLineCell
        
        let railLine = railLines[indexPath.row]
        cell.railLineDisplayName.text = "\(railLine.displayName)"
        cell.backgroundColor = railLine.getColor()
        
        let colorView = UIView()
        colorView.backgroundColor = railLine.getSelectedColor()
        cell.selectedBackgroundView = colorView
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RailLineToStation" {
            let railStationTableViewController: RailStationTableViewController = segue.destinationViewController as! RailStationTableViewController
                        
            let railLine = railLines[(tableView.indexPathForSelectedRow?.row)!]
            railStationTableViewController.lineCode = railLine.getLineCode()
            railStationTableViewController.color = railLine.getColor()
        }
    }
}
