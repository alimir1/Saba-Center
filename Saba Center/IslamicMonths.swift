//
//  IslamicMonths.swift
//  Saba Center
//
//  Created by Ali Mir on 11/17/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import Foundation

enum IslamicMonths: Int {
    case Muharram = 1, Safar, RabiAwwal, RabiThani, JamadiAwwal, JamadiThani, Rajab, Shaban, Ramadhan, Shawwal, DhilQaeda, DhilHijjah
    
    var string: String {
        switch self {
        case .RabiAwwal:
            return "Rabi-ul-Awwal"
        case .RabiThani:
            return "Rabi-ul-Thani"
        case .JamadiAwwal:
            return "Jamadi-ul-Awwal"
        case .JamadiThani:
            return "Jamadi-ul-Thani"
        case .DhilQaeda:
            return "Dhil Qaeda"
        case .DhilHijjah:
            return "Dhil Hijjah"
        default:
            return String(describing: self)
        }
    }
}
