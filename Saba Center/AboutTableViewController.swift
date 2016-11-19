//
//  AboutTableViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/15/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - Navigation

extension AboutTableViewController {
    
    enum SegueIDs: String {
        case residentAlim, history
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case SegueIDs.residentAlim.rawValue:
            let residentAlimVC = segue.destination as! DisplayInformationViewController
            residentAlimVC.pageAttributedText = SabaInfo.Informations.residentAlim.attributedString
            residentAlimVC.headerView.image = #imageLiteral(resourceName: "MoulanaAbidi")
        case SegueIDs.history.rawValue:
            let historyVC = segue.destination as! DisplayInformationViewController
            historyVC.pageAttributedText = SabaInfo.Informations.history.attributedString
            historyVC.headerView.image = #imageLiteral(resourceName: "PlaceHolder")
        default:
            break
        }
    }
}

// MARK: - Table View

extension AboutTableViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        } else {
             return self.tableView.estimatedSectionHeaderHeight
        }
    }
}
