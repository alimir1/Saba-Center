//
//  WeeklyProgramsTableViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/10/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
//import PrayTime

class WeeklyProgramsTableViewController: UITableViewController {
    
    var weeklyPrograms: [SabaCenterData.WeeklyProgram]?
    
    var testDay: [SabaCenterData.Schedule]? {
        return weeklyPrograms?[0].schedules
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let googleDocsClient = GoogleDocsClient.sharedInstance()
//        googleDocsClient.getWeeklyPrograms {
//            (data, error) in
//            guard (error == nil) else {
//                print ("ERROR! \(error)")
//                return
//            }
//            
//            if let data = data, data.count > 0 {
//                performUIUpdatesOnMain {
//                    self.weeklyPrograms = data
//                    self.tableView.reloadData()
//                }
//            } else {
//                print("There is no data!")
//            }
//        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDay?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyProgramCell", for: indexPath) as! WeeklyProgramsTableViewCell
        
        let schedule = testDay?[indexPath.row]
        
        cell.title.text = schedule?.time
        cell.detail.text = schedule?.program

        return cell
    }

}
