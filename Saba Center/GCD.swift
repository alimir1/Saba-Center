//
//  GCD.swift
//  Saba Center
//
//  Created by Ali Mir on 11/10/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import Foundation

func performUIUpdatesOnMain(updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
