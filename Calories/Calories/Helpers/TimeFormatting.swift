//
//  TimeFormatting.swift
//  Calories
//
//  Created by jaewon Lee on 5/10/24.
//

import Foundation

func calcTimeSince(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow) / 60
    let hours = minutes / 60
    let days = hours / 24
    
    if minutes < 120 {
        return "\(minutes) minutes ago"
    } else if minutes >= 120 && minutes <= 48 {
        return "\(hours) houres ago"
    } else {
        return "\(days) days ago"
    }
}
