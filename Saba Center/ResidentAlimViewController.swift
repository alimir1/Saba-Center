//
//  ResidentAlimViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/15/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import MXParallaxHeader

class ResidentAlimViewController: UIViewController {
    
    let text = "Syed Nabi Raza Abidi was born and raised in Alipour, India into a religious, Syed family from both parents. After completing his early education at the age of 14, he moved to Iran to pursue further Islamic studies. He spent the first 2 years learning Farsi, basic Arabic grammar, and Ahkam in Najafabad, Isfahan, and then relocated to Qom for approximately 13 years. In Qom, he studied at renowned Islamic seminaries and institutes such as the Institute of Imam Jafar as-Sadiq under the guidance of Ayatollah Jafar Subhani while concurrently earning his PhD in Theology and Philosophy from a sister school at the University of Tehran. Upon completing his lower level studies, he began his higher hawzah education, Dars al-Kharij, under many reputable scholars, such as Ayatollah Fadhel Lankarani, Ayatullah Bahjat, and Ayatollah Jafer Subhani."
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutLabel.text = text
        
        viewHeightConstraint.constant = viewHeightConstraint.constant + aboutLabel.reqiuredHeight

        let headerView = UIImageView()
        headerView.image = #imageLiteral(resourceName: "MoulanaAbidi")
        headerView.contentMode = .scaleAspectFill
        scrollView.parallaxHeader.view = headerView
        scrollView.parallaxHeader.height = 200
        scrollView.parallaxHeader.mode = .fill
        scrollView.parallaxHeader.minimumHeight = 0
        
    }
}

extension UILabel {
    var reqiuredHeight: CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.width))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = self.font
        label.sizeToFit()
        
        return label.frame.height
    }
}
