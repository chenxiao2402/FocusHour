//
//  Locolization.swift
//  FocusHour
//
//  Created by Midrash Elucidator on 2019/2/12.
//  Copyright © 2019 Midrash Elucidator. All rights reserved.
//

import Foundation

enum LocalizationKey: String {
    case Start = "Start"
    case SetTimeTitle = "SetTimeTitle"
    case PurchasePrompt = "PurchasePrompt"
    case Price = "Price"
    case Coins = "Coins"
    case PurchaseSuccess = "PurchaseSuccess"
    case InsufficientCoins = "InsufficientCoins"
    
    case CountdownTitle = "CountdownTitle"
    case Congratulations = "Congratulations"
    case Encouragement = "Encouragement"
    case YouCanDoBetter = "YouCanDoBetter"
    case Giveup = "Giveup"
    case GiveupAlertTitle = "GiveupAlert-Title"
    case GiveupAlertDeathMessage = "GiveupAlert-DeathMessage"
    case GiveupAlertHoldOnMessage = "GiveupAlert-HoldOnMessage"
    
    case Yes = "Yes"
    case No = "No"
    case Cancel = "Cancel"
    case NotificationSuccess = "Notification-Success"
    case NotificationFailure = "Notification-Failure"
    case NotificationAlert = "Notification-Alert"
    
    case None = "None"
    case Wind = "Wind"
    case Stream = "Stream"
    case Birds = "Birds"
    case Insects = "Insects"
    case Rain = "Rain"
    
    case Thunderstorm = "Thunderstorm"
    case Settings = "Settings"
    case SetLanguage = "SetLanguage"
    case SetPhrase = "SetPhrase"
    case ChangeTheme = "ChangeTheme"
    case WorkingMode = "WorkingMode"
    case NightMode = "NightMode"
    case ThisApp = "ThisApp"
    case About = "About"
    
    case Theme = "Theme"
    case One = "One"
    case Two = "Two"
    case Three = "Three"
    case Four = "Four"
    case Five = "Five"
    
    case Introduction = "Introduction"
    case AboutUs = "AboutUs"
    
    case Jan = "Jan"
    case Feb = "Feb"
    case Mar = "Mar"
    case Apr = "Apr"
    case May = "May"
    case Jun = "Jun"
    case Jul = "Jul"
    case Aug = "Aug"
    case Sep = "Sep"
    case Oct = "Oct"
    case Nov = "Nov"
    case Dec = "Dec"
    case Hour = "Hour"
    case Minute = "Minute"
    
    case ARForest = "ARForest"
}

extension LocalizationKey {
    func translate() -> String {
        return LocalizationTool.translate(self.rawValue)
    }
}
