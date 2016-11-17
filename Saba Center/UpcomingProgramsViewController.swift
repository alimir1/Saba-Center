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
    
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    var viewForActivityIndicator: UIView = UIView()
    
    var upcomingPrograms: [SabaCenterData.UpcomingProgram] = [] {
        didSet {
            self.stopActivityIndicator()
        }
    }
    
    var imageCache = [URL : UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchUpcomingPrograms()
    }
    
    // MARK: - Table view

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
            
        if let imageurl = URL(string: upcomingProgram.imageURL!) {
            Nuke.loadImage(with: imageurl, into: cell.sabaProgramsImageView)
        }
        return cell
    }
}

// MARK: - Helpers

extension UpcomingProgramsViewController {
    func fetchUpcomingPrograms() {
        showActivityIndicator()
        GoogleDocsClient.shared().getUpcomingPrograms {
            (data, error) in
            if let data = data {
                self.upcomingPrograms = data
                self.tableView.reloadData()
            } else {
                // FIXME: ERROR HANDLING!
            }
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
    
    func showActivityIndicator() {
        viewForActivityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        viewForActivityIndicator.backgroundColor = UIColor.white
        self.view.addSubview(viewForActivityIndicator)

        activityIndicatorView.center = viewForActivityIndicator.center
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.activityIndicatorViewStyle = .gray
        viewForActivityIndicator.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func stopActivityIndicator() {
        viewForActivityIndicator.removeFromSuperview()
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
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

