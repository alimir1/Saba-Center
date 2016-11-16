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
    
    var imageCache = [URL : UIImageView]()
    
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

        cell.upcomingProgramTextView.attributedText = makeAttributedString(title: upcomingProgram.title, subtitle: upcomingProgram.description)
//        cell.detailTextLabel?.text = description
//        let countNewLines = description.components(separatedBy: "\n").count + 1
//        cell.detailTextLabel?.numberOfLines = countNewLines
//        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        
        cell.accessoryView = UIImageView(image: #imageLiteral(resourceName: "PlaceHolder"))
        
        if let imageurl = URL(string: upcomingProgram.imageURL!) {
            if let img = imageCache[imageurl] {
                cell.accessoryView = img
            } else {
                if let data = try? Data(contentsOf: imageurl) {
                    if let image = UIImage(data: data) {
                        let imgView = UIImageView(image: image)
                        imgView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 110.0)
                        imgView.layer.cornerRadius = 8.0
                        imgView.contentMode = .scaleAspectFit
                        imageCache[imageurl] = imgView
                        performUIUpdatesOnMain {
                            cell.accessoryView = imgView
                        }
                    }
                }
            }
        }

        return cell
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
//        let subtitleAttributes = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: .subheadline)]
        
        let titleString = NSMutableAttributedString(string: "\(titlePlain)\n", attributes: titleAttributes)
//        let subtitleString = NSAttributedString(string: subtitle, attributes: subtitleAttributes)
        
        
        
        titleString.append(description)
        
        return titleString
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


