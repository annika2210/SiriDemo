//
//  ShowNextLectureIntentHandler.swift
//  IntentKit
//
//  Created by Annika Pfosch on 26.10.20.
//

import Foundation

public class ShowNextLectureIntentHandler : NSObject, ShowNextLectureIntentHandling {
    
    var converter = Converter()
    
    public func confirm(intent: ShowNextLectureIntent, completion: @escaping (ShowNextLectureIntentResponse) -> Void) {
        completion(ShowNextLectureIntentResponse(code: .ready, userActivity: nil))
    }
    
    public func handle(intent: ShowNextLectureIntent, completion: @escaping (ShowNextLectureIntentResponse) -> Void) {
        let events = CalendarAccess.sharedInstance.getLectureEvents()
        var title : String = "Kein Titel"
        var startTime : String = ""
        var room : String = ""
        
        if (!events.isEmpty ) {
            let nextLecture = events.first
            title = (nextLecture?.event.title)!
            startTime = converter.convertDate(date: (nextLecture?.event.startDate.description)!)
            room = converter.convertLocation2Room(room: (nextLecture?.event.location)!)
            
            completion(ShowNextLectureIntentResponse.success(title: "\(title)", startTime: "\(startTime)", room: "\(room)"))
        }
        
        else {
            completion(ShowNextLectureIntentResponse(code: .failure, userActivity: nil))
        }
    }
    
}
