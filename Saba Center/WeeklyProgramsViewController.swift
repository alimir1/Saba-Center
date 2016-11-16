//
//  WeeklyProgramsViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/14/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class WeeklyProgramsViewController: UITableViewController {

    var timeTable: [SabaCenterData.Schedule] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Table View

extension WeeklyProgramsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeTable.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyProgramCell", for: indexPath)
        let schedule = timeTable[indexPath.row]
        
        let program = try! NSAttributedString(
            data: schedule.program.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        
        cell.textLabel?.text = schedule.time
        cell.detailTextLabel?.text = program.string
        
        return cell
    }
}
