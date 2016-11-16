//
//  GoogleDocsConvenience.swift
//  Saba Center
//
//  Created by Ali Mir on 11/6/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import Foundation

// MARK: - GoogleDocsClient (Convenient Resource Methods)

extension GoogleDocsClient {

    // MARK: GET Convenience Methods
    
    func getUpcomingPrograms(completionHandler: @escaping (_ data: [SabaCenterData.UpcomingProgram]?, _ error: Error?) -> Void) {
        
        _ = taskForGETMethod(sectionCode: GoogleDocsClient.SectionCodes.UpcomingPrograms) {
        (result, error) in
            
            if let error = error {
                completionHandler(nil, error)
            } else {
                if let data = result as? [String : AnyObject], let feed = data[GoogleDocsClient.JSONResponseKeys.Feed] as? [String : AnyObject], let entry = feed[GoogleDocsClient.JSONResponseKeys.Entry] as? [[String : AnyObject]] {
                    
                    var upcomingPrograms: [SabaCenterData.UpcomingProgram] = []
                    
                    for e in entry {
                        if let title = (e[GoogleDocsClient.JSONResponseKeys.Title] as? [String : String])?[GoogleDocsClient.JSONResponseKeys.Text], let description = (e[GoogleDocsClient.JSONResponseKeys.Description] as? [String : String])?[GoogleDocsClient.JSONResponseKeys.Text] {
                            let imageURL = (e[GoogleDocsClient.JSONResponseKeys.ImageURL] as? [String : String])?[GoogleDocsClient.JSONResponseKeys.Text]
                            let upcomingProgram = SabaCenterData.UpcomingProgram(title: title, description: description, imageURL: imageURL)
                            
                            upcomingPrograms.append(upcomingProgram)
                        }
                    }
                    
                    completionHandler(upcomingPrograms, nil)
                    
                } else {
                    completionHandler(nil, NSError(domain: "getUpcomingPrograms parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse data getUpcomingPrograms"]))
                }
            }
        }
    }
    
    func getWeeklyPrograms(completionHandler: @escaping (_ data: [SabaCenterData.WeeklyProgram], _ error: Error?) -> Void) {
    
        _ = taskForGETMethod(sectionCode: GoogleDocsClient.SectionCodes.WeeklyPrograms) {
            (result, error) in
            
            var weeklyPrograms: [SabaCenterData.WeeklyProgram] = []
            
            if let error = error {
                completionHandler(weeklyPrograms, error)
            } else {
                if let data = result as? [String : AnyObject], let feed = data[GoogleDocsClient.JSONResponseKeys.Feed] as? [String : AnyObject], let entry = feed[GoogleDocsClient.JSONResponseKeys.Entry] as? [[String : AnyObject]] {
                    
                    var count = -1
                    
                    for e in entry {
                        if let englishDate = (e[GoogleDocsClient.JSONResponseKeys.EnglishDate] as? [String : String])?[GoogleDocsClient.JSONResponseKeys.Text], let hijriDate = (e[GoogleDocsClient.JSONResponseKeys.HijriDate] as? [String : String])?[GoogleDocsClient.JSONResponseKeys.Text], let day = (e[GoogleDocsClient.JSONResponseKeys.Day] as? [String : String])?[GoogleDocsClient.JSONResponseKeys.Text], let time = (e[GoogleDocsClient.JSONResponseKeys.Time] as? [String : String])?[GoogleDocsClient.JSONResponseKeys.Text], let program = (e[GoogleDocsClient.JSONResponseKeys.Program] as? [String : String])?[GoogleDocsClient.JSONResponseKeys.Text] {

                            if (englishDate != "") {
                                // new day
                                // get rid of the "'"s from English Date
                                let newEnglishDate = englishDate.replacingOccurrences(of: "\'", with: "", options: .literal, range: nil)
                                
                                let weeklyProgram = SabaCenterData.WeeklyProgram(day: day, englishDate: newEnglishDate, hijriDate: hijriDate, schedules: [])
                                weeklyPrograms.append(weeklyProgram)
                                count += 1
                            } else {
                                let schedule = SabaCenterData.Schedule(time: time, program: program)
                                weeklyPrograms[count].schedules.append(schedule)
                            }
                        }
                    }
                    
                    completionHandler(weeklyPrograms, nil)
                    
                } else {
                    completionHandler(weeklyPrograms, NSError(domain: "getWeeklyPrograms parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse data getWeeklyPrograms"]))
                
                }
            }
        }
    
    }
    
}












