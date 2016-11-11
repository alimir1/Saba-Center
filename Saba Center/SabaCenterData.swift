//
//  SabaCenterData.swift
//  Saba Center
//
//  Created by Ali Mir on 11/6/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import Foundation

struct SabaCenterData {
    struct UpcomingProgram {
        let title: String
        let description: String?
        let imageURL: String?
    }
    
    struct Schedule {
        let time: String
        let program: String
    }
    
    struct WeeklyProgram {
        let day: String
        let englishDate: String
        let hijriDate: String
        var schedules: [Schedule]
    }
}
