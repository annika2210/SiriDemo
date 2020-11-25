//
//  NSUserActivity+IntentData.swift
//  IntentKit
//
//  Created by Annika Pfosch on 26.10.20.
//

import Foundation
import Intents

extension NSUserActivity {
    public static  let showNextLectureActivityType = "annika.pfosch.student.intentkit.shownextlecture"
    
    public static var showNextLectureActivity : NSUserActivity {
        let userActivity = NSUserActivity(activityType: NSUserActivity.showNextLectureActivityType)
        
        userActivity.title = "Show next Lecture"
        userActivity.persistentIdentifier = NSUserActivityPersistentIdentifier(NSUserActivity.showNextLectureActivityType)
        userActivity.isEligibleForPrediction = true
        userActivity.suggestedInvocationPhrase = "Wo ist meine nächste Vorlesung?"
        
        return userActivity
    }
}
