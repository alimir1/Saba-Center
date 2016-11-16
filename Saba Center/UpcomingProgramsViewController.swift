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
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//    
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingProgramCell", for: indexPath) as! UpcomingProgramsCell
        
        let upcomingProgram = upcomingPrograms[indexPath.row]
        
        cell.upcomingProgramText.attributedText = makeAttributedString(title: upcomingProgram.title, subtitle: upcomingProgram.description)
        
        
        
        cell.programImage.image = #imageLiteral(resourceName: "PlaceHolder")
        let url = URL(string: upcomingProgram.imageURL!)!
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let imageData = data {
                let image = UIImage(data: imageData)
                if let image = image {
                    performUIUpdatesOnMain {
                        let updateCell = self.tableView.cellForRow(at: indexPath)
                        if let updatedCell = updateCell as? UpcomingProgramsCell {
                            updatedCell.programImage.image = image
                            self.tableView.reloadRows(at: [indexPath], with: .none)
                        }
                    }
                }
            }
            
        }
        task.resume()
        
//        cell.programImage.image = #imageLiteral(resourceName: "PlaceHolder")
//        
//        DispatchQueue.global(qos: DispatchQoS.background.qosClass).async {
//            do {
//                let data = try Data(contentsOf: URL(string: upcomingProgram.imageURL!)!)
//                let getImage = UIImage(data: data)
//                DispatchQueue.main.async {
//                    let updateCell = self.tableView.cellForRow(at: indexPath) as? UpcomingProgramsCell
//                    if let updatedCell = updateCell {
//                        updatedCell.programImage.image = getImage
//                    }
//                    return
//                }
//            }
//            catch {
//                return
//            }
//        }
        
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


