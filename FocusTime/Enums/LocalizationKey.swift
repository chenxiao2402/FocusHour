//
//  Locolization.swift
//  FocusTime
//
//  Created by Midrash Elucidator on 2019/2/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

enum LocalizationKey: String {
    case Start = "Start"
    case Giveup = "Giveup"
    
    case GiveupAlertTitle = "GiveupAlert-Title"
    case GiveupAlertDeathMessage = "GiveupAlert-DeathMessage";
    case GiveupAlertEncouragement = "GiveupAlert-Encouragement";
    
    case Yes = "Yes";
    case No = "No";
    case Cancel = "Cancel";
    
    case Settings = "Settings";
    case SetLanguage = "SetLanguage";
    case About = "About";
    case English = "English";
    case Chinese = "Chiense";
    case Japanese = "Japanese";
    
    case Description = "Description";
    case AboutMe = "AboutMe";
    
    case NotificationSuccess = "Notification-Success";
    case NotificationAlert = " Notification-Alert"
    
    case None = "None";
    case Wind = "Wind";
    case Stream = "Stream";
    case Birds = "Birds";
    case Insects = "Insects";
    case Rain = "Rain";
    case Thunderstorm = "Thunderstorm";
}

extension LocalizationKey {
    func translate() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
