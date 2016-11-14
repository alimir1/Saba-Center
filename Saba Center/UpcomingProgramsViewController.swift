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
        
        cell.upcomingProgramText.attributedText = makeAttributedString(title: upcomingProgram.title, subtitle: upcomingProgram.description)
        
        return cell
    }
    
    func makeAttributedString(title: String, subtitle: String) -> NSAttributedString {
//        let titleAttributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .headline)]
//        let subtitleAttributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        let title = try! NSMutableAttributedString(
            data: title.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        
        let description = try! NSAttributedString(
            data: subtitle.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        
        title.append(NSAttributedString(string: "\n"))
        title.append(description)
        
        return title
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


