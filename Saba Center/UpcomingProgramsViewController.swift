//
//  UpcomingProgramsViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/14/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class UpcomingProgramsViewController: UITableViewController {
    
    var upcomingPrograms: [SabaCenterData.UpcomingProgram] = [] {
        didSet {
            performUIUpdatesOnMain {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performUIUpdatesOnMain() {
            self.fetchUpcomingPrograms()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingPrograms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingProgramCell", for: indexPath)
        
        let upcomingProgram = upcomingPrograms[indexPath.row]
        
        let title = upcomingProgram.title
        let description = upcomingProgram.description
        let imageURL = upcomingProgram.imageURL
        
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = description ?? ""
        
        if let imageURL = imageURL {
            let url = URL(string: imageURL)
            DispatchQueue.global().async {
                if let url = url {
                    if let data = try? Data(contentsOf: url) {
                        performUIUpdatesOnMain {
                            cell.imageView?.image = UIImage(data: data)
                        }
                    }
                }
            }
        }

        return cell
    }
 

}

// MARK: - Helpers

extension UpcomingProgramsViewController {
    func fetchUpcomingPrograms() {
        GoogleDocsClient.shared().getUpcomingPrograms {
            (data, error) in
            if let data = data {
                self.upcomingPrograms = data
            } else {
                // FIXME: ERROR HANDLING!
            }
            
        }
    }
}


