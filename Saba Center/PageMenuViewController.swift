//
//  PageMenuViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/15/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit
import PageMenu

class PageMenuViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var weeklyPrograms: [SabaCenterData.WeeklyProgram] = [] {
        didSet {
            populateViewControllers()
        }
    }
    
    var pageMenu: CAPSPageMenu?
    
    // Array to keep track of controllers in page menu
    var controllerArray : [UIViewController] = [] {
        didSet {
            setupPageMenu()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchWeeklyPrograms()
    }
}

// MARK: - Helpers

extension PageMenuViewController {
    func fetchWeeklyPrograms() {
        GoogleDocsClient.shared().getWeeklyPrograms() {
            (data, error) in
            guard (error == nil) else {
                // FIXME: ERROR HANDLING
                return
            }
            self.weeklyPrograms = data
        }
    }
    
    func populateViewControllers() {
        for program in weeklyPrograms {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewCtrl = storyboard.instantiateViewController(withIdentifier: "weeklyPrograms") as! WeeklyProgramsViewController
            viewCtrl.title = SabaCenterData.WeeklyProgram.DaysOfTheWeek(rawValue: program.day)?.getAbbreviatedDayString ?? program.day
            for schedule in program.schedules {
                if schedule.time != "<br>" {
                    viewCtrl.timeTable.append(schedule)
                }
            }
            controllerArray.append(viewCtrl)
        }
    }
    
    func setupPageMenu() {
        // Customize page menu to your liking (optional) or use default settings by sending nil for 'options' in the init
        // Example:
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(4.3),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        
        let frame = CGRect(x: 0.0, y: 0.0, width: containerView.frame.width, height: containerView.frame.height)
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: frame, pageMenuOptions: parameters)
        
        // Lastly add page menu as subview of base view controller view
        // or use pageMenu controller in you view hierachy as desired
//        self.view.addSubview(pageMenu!.view)
        containerView.addSubview(pageMenu!.view)
    }
}

