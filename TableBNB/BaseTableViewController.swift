//
//  BaseTableViewController.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - TableViewController

class TableViewController<Cell: UITableViewCell where Cell: Configurable>: UITableViewController {
    typealias DataType = Cell.DataType
    
    // MARK: - Cell Identifier Declaration
    
    private let cellIdentifier = String(Cell)
    
    // MARK: - Data Declaration
    
    var data: [DataType] = [] {
        didSet {
            tableView.reloadData()
            if tableView.numberOfRowsInSection(0) > 0 {
                tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Top, animated: true)
            }
        }
    }
    
    // MARK: - TableViewController Initializer
    
    init() { super.init(nibName: nil, bundle: nil) }
    
    // MARK: - TableViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(Cell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60 // TODO: Move to stylesheet
    }
    
    // MARK: - TableViewDataSource Required Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! Cell
        cell.configure(withItem: data[indexPath.row])
        return cell
    }
}