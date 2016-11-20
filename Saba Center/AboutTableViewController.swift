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
            residentAlimVC.navigationController?.title = "Resident Alim"
            residentAlimVC.pageAttributedText = SabaInfo.Informations.residentAlim.attributedString
            residentAlimVC.headerView.image = #imageLiteral(resourceName: "MoulanaAbidi")
        case SegueIDs.history.rawValue:
            let historyVC = segue.destination as! DisplayInformationViewController
            historyVC.navigationController?.title = "History"
            historyVC.pageAttributedText = SabaInfo.Informations.history.attributedString
            historyVC.headerView.image = #imageLiteral(resourceName: "HistoryClock")
        default:
            break
        }
    }
}

// MARK: - Table View

extension AboutTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let footerView = view as? UITableViewHeaderFooterView {
            footerView.textLabel?.textAlignment = .center
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        } else {
             return self.tableView.estimatedSectionHeaderHeight
        }
    }
}
