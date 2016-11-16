//
//  SabaCenterData.swift
//  Saba Center
//
//  Created by Ali Mir on 11/6/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

struct SabaCenterData {
    struct UpcomingProgram {
        let title: String
        let description: String
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
        
        enum DaysOfTheWeek: String {
            case Monday
            case Tuesday
            case Wednesday
            case Thursday
            case Friday
            case Saturday
            case Sunday
            
            var getAbbreviatedDayString: String {
                switch self {
                case .Monday:
                    return "Mon"
                case .Tuesday:
                    return "Tue"
                case .Wednesday:
                    return "Wed"
                case .Thursday:
                    return "Thurs"
                case .Friday:
                    return "Fri"
                case .Saturday:
                    return "Sat"
                case .Sunday:
                    return "Sun"
                }
            }
        }
    }
}
