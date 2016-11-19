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
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    let headerView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textForLabel  = "Syed Nabi Raza Abidi was born and raised in Alipur, Karnataka (India) into a religious, Syed family from both parents.\nldskjldksfjdsf\nlksdjfdlksfjds\nlksdjfkldsjfdls\nlkjdslkfjdsklfj"
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5.5
        let pageTitleAttributes = [NSForegroundColorAttributeName: UIColor.gray]
        let pageDescriptionAttributes = [NSParagraphStyleAttributeName : paragraphStyle]
        let pageTitleText = NSMutableAttributedString(string: "Moulana Nabi Raza Abidi\nResident A'lim of Saba\n\n", attributes: pageTitleAttributes)
        let pageDescriptionText = NSAttributedString(string: textForLabel, attributes: pageDescriptionAttributes)
        pageTitleText.append(pageDescriptionText)
        
        
        testLabel.attributedText = pageTitleText
        testHeightConstraint.constant = 20.0
        
        configureScrollViewHeader()
        
    }
}

// MARK: - Helpers

extension DisplayInformationViewController {
    func configureScrollViewHeader() {
        headerView.image = #imageLiteral(resourceName: "MoulanaAbidi")
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
