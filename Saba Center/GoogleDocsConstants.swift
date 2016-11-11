//
//  GoogleDocsConstants.swift
//  Saba Center
//
//  Created by Ali Mir on 11/6/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import Foundation

extension GoogleDocsClient {
    
    // MARK: - Constants
    struct Costants {
        
        // MARK: URLs
        static let Scheme = "https"
        static let Host = "spreadsheets.google.com"
        static let Path = "/feeds/list/18LkG2wziAIp7bHeRXl8XfSD1rwtiPgmMWDgNEl3X58w/{section_code}/public/values"
    }
    
    // MARK: - Section Codes
    struct SectionCodes {
        static let SectionCode = "section_code"
        static let UpcomingPrograms = "od7"
        static let WeeklyPrograms = "od4"
        static let CommunityAnnouncements = "od5"
    }
    
    // MARK: - JSON Response Keys
    struct JSONResponseKeys {
        
        // General
        static let Feed = "feed"
        static let Entry = "entry"
        static let Title = "gsx$title"
         static let Text = "$t"

        // Upcoming Programs
        static let Description = "gsx$description"
        static let ImageURL = "gsx$imageurl"
        
        // Weekly Programs
        static let Program = "gsx$program"
        static let Time = "gsx$time"
        static let EnglishDate = "gsx$englishdate"
        static let HijriDate = "gsx$hijridate"
        static let Day = "gsx$day"
        
    }
}
