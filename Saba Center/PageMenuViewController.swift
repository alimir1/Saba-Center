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
    
    // MARK: - Properties
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var containerView: UIView!
    
    var activityIndicator: ActivityIndicator!
    
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
    
    // MARK: - Life View Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup activity indicator
        activityIndicator = ActivityIndicator(view: self.view, navigationController: self.navigationController, tabBarController: self.tabBarController)
        activityIndicator.showActivityIndicator()
        
        // Fetch weekly programs from the APi
        self.fetchWeeklyPrograms()
    }
    
    // MARK: - Actions
    
    @IBAction func refreshPage(sender: AnyObject?) {
        refreshButton.isEnabled = false
        activityIndicator.showActivityIndicator()
        controllerArray.removeAll()
        self.fetchWeeklyPrograms()
    }
    
}

// MARK: - Helpers

extension PageMenuViewController {
    func fetchWeeklyPrograms() {
        GoogleDocsClient.shared().getWeeklyPrograms() {
            (data, error) in
            
            // Stop activity indicator and enable refresh button
            self.refreshButton.isEnabled = true
            self.activityIndicator.stopActivityIndicator()
            
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
            viewCtrl.timeTable.append(SabaCenterData.Schedule(time: "Date", program: "\(program.englishDate) / \(program.hijriDate)"))
            for schedule in program.schedules {
                if schedule.time != "<br>" {
                    viewCtrl.timeTable.append(schedule)
                }
            }
            controllerArray.append(viewCtrl)
        }
    }
    
    func setupPageMenu() {
        // Customize page menu
        let themeColor = UIColor(red:0.16, green:0.70, blue:0.40, alpha:1.0)
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(3.5),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorPercentageHeight(0.1),
            .selectedMenuItemLabelColor(UIColor.white),
            .unselectedMenuItemLabelColor(UIColor.white),
            .selectionIndicatorColor(themeColor),
            .scrollMenuBackgroundColor(UIColor.brown),
        ]
        
        // Initialize page menu with controller array, frame, and optional parameters
        let frame = CGRect(x: 0.0, y: 0.0, width: containerView.frame.width, height: containerView.frame.height)
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: frame, pageMenuOptions: parameters)
        
        // Add page menu as subview of base view controller view
        containerView.addSubview(pageMenu!.view)
    }
}

