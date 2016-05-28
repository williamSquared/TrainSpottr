//
//  RailLineTableViewController.swift
//  TrainSpottr
//
//  Created by Will Williams on 5/26/16.
//  Copyright © 2016 Will Williams. All rights reserved.
//


import UIKit

class RailLineTableViewController: UITableViewController {
    
    private let cellId = "cell"
    private let railLines: [RailLine]? = nil
    @IBOutlet weak var railLineTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        WMATAService.getRailLines(){ (result) -> Void in
            if let railLines = result {
                self.railLineTableView.reloadData()
            }
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let lines = railLines {
            return lines.count
        } else {
            return 1
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
    
}
