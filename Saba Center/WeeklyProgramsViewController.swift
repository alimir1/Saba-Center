//
//  WeeklyProgramsViewController.swift
//  Saba Center
//
//  Created by Ali Mir on 11/14/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

private let reuseIdentifier = "daysOfWeekCollectionCell"

class WeeklyProgramsViewController: UIViewController {
    var weeklyPrograms: [SabaCenterData.WeeklyProgram] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var testDay: [SabaCenterData.Schedule]? {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let one = SabaCenterData.WeeklyProgram(day: "Monday", englishDate: "32/23", hijriDate: "tse", schedules: [SabaCenterData.Schedule(time: "33:44", program: "SomeProgram")])
        let two = SabaCenterData.WeeklyProgram(day: "Friday", englishDate: "32/23", hijriDate: "tse", schedules: [SabaCenterData.Schedule(time: "33:44", program: "SomeProgram")])
        let three = SabaCenterData.WeeklyProgram(day: "Tuesday", englishDate: "32/23", hijriDate: "tse", schedules: [SabaCenterData.Schedule(time: "33:44", program: "SomeProgram")])
        let four = SabaCenterData.WeeklyProgram(day: "Wednesday", englishDate: "32/23", hijriDate: "tse", schedules: [SabaCenterData.Schedule(time: "33:44", program: "SomeProgram")])
        let five = SabaCenterData.WeeklyProgram(day: "Thursday", englishDate: "32/23", hijriDate: "tse", schedules: [SabaCenterData.Schedule(time: "33:44", program: "SomeProgram")])
        
        weeklyPrograms.append(one)
        weeklyPrograms.append(two)
        weeklyPrograms.append(three)
        weeklyPrograms.append(four)
        weeklyPrograms.append(five)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Helpers

extension WeeklyProgramsViewController {
}

// MARK: - Table View

extension WeeklyProgramsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testDay?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyProgramCell", for: indexPath) as! WeeklyProgramsTableViewCell
        let schedule = testDay?[indexPath.row]
        
        cell.textLabel?.text = schedule?.time
        cell.detailTextLabel?.text = schedule?.program
        
        return cell
    }
}

// MARK: - CollectionView

extension WeeklyProgramsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DaysOfWeekCollectionCellCell
        let dayOfWeek = weeklyPrograms[indexPath.row].day
        cell.dayOfWeek.setTitle(dayOfWeek, for: .normal)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weeklyPrograms.count
    }
}

