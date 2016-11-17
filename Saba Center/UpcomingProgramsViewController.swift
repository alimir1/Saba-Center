//
//  UpcomingProgramsViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/14/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import Nuke

class UpcomingProgramsViewController: UITableViewController {
    
    // MARK: - Properties
    
    internal lazy var refreshCTRL = UIRefreshControl()
    internal var activityIndicator: ActivityIndicator!
    
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    var viewForActivityIndicator: UIView = UIView()
    
    var upcomingPrograms: [SabaCenterData.UpcomingProgram] = [] {
        didSet {
            self.tableView.isScrollEnabled = true
            self.tableView.separatorStyle = .singleLine
        }
    }
    
    // MARK: - View Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup activity indicator view
        activityIndicator = ActivityIndicator(view: self.view, navigationController: self.navigationController, tabBarController: self.tabBarController)
        
        // Setup the refresh control.
        tableView.addSubview(refreshCTRL)
        refreshCTRL.addTarget(self, action: #selector(self.fetchUpcomingPrograms), for: .valueChanged)
        
        // Fetch upcoming programs from the API.
        activityIndicator.showActivityIndicator(adjustHeightForBars: true)
        self.tableView.separatorStyle = .none
        self.tableView.isScrollEnabled = false
        self.fetchUpcomingPrograms()
    }
}

// MARK: - Helpers

extension UpcomingProgramsViewController {
    func fetchUpcomingPrograms() {
        GoogleDocsClient.shared().getUpcomingPrograms {
            (data, error) in
            if let data = data {
                self.upcomingPrograms = data
                self.tableView.reloadData()
            } else {
                // FIXME: ERROR HANDLING!
            }
            
            // Stop animating the refresh control and stop activity indicator
            self.refreshCTRL.endRefreshing()
            self.activityIndicator.stopActivityIndicator()
        }
    }

    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
        let titlePlain = try! NSAttributedString(
            data: title.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil).string
        let description = try! NSAttributedString(
            data: subtitle.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        let titleAttributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline), NSForegroundColorAttributeName: UIColor.darkGray]
        let titleString = NSMutableAttributedString(string: "\(titlePlain)\n", attributes: titleAttributes)
        
        titleString.append(description)
        
        return titleString
    }
}

// MARK: - Table view

extension UpcomingProgramsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingPrograms.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingProgramCell", for: indexPath) as! UpcomingProgramsCell
        let upcomingProgram = upcomingPrograms[indexPath.row]
        
        cell.upcomingProgramTextView.attributedText = makeAttributedString(title: upcomingProgram.title, subtitle: upcomingProgram.description)
        
        if let imageurl = URL(string: upcomingProgram.imageURL ?? "") {
            Nuke.loadImage(with: imageurl, into: cell.sabaProgramsImageView)
        }
        
        return cell
    }
}

extension Data {
    var attributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options:[NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}

extension String {
    var utf8Data: Data? {
        return data(using: .utf8)
    }
}

