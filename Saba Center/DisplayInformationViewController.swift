//
//  DisplayInformationViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/19/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import MXParallaxHeader

class DisplayInformationViewController: UIViewController {
    
    
    // MARK: - Properties
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var headerView = UIImageView()
    var pageAttributedText: NSAttributedString = NSAttributedString(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testLabel.attributedText = pageAttributedText
        testHeightConstraint.constant = 30.0
        
        configureScrollViewHeader()
        
    }
}

// MARK: - Helpers

extension DisplayInformationViewController {
    func configureScrollViewHeader() {
        headerView.contentMode = .scaleAspectFill
        scrollView.parallaxHeader.view = headerView
        scrollView.parallaxHeader.height = 200
        scrollView.parallaxHeader.mode = .fill
        scrollView.parallaxHeader.minimumHeight = 0
    }
}

// MARK: - UILabel Extension

extension UILabel {
    var reqiuredHeight: CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.width))
        label.attributedText = self.attributedText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = self.font
        label.sizeToFit()
        
        return label.frame.height
    }
}
