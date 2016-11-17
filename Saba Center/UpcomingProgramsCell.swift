//
//  UpcomingProgramsCell.swift
//  Saba Center
//
//  Created by Ali Mir on 11/14/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class UpcomingProgramsCell: UITableViewCell {
    
    @IBOutlet weak var upcomingProgramTextView: UITextView!
    
    var sabaProgramsImageView: UIImageView = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sabaProgramsImageView.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 110.0)
        sabaProgramsImageView.contentMode = .scaleAspectFit
        accessoryView = sabaProgramsImageView
    }
}
