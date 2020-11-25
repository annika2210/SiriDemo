//
//  CalendarAccess.swift
//  SiriDemo
//
//  Created by Annika Pfosch on 26.10.20.
//

import Foundation
import EventKit

class CalendarAccess {
    
    public static var sharedInstance = CalendarAccess()
    var eventStore = EKEventStore()
    var calendar : EKCalendar?
    @Published var accessGranted = false
    var showAlert : Bool = false
    let calendarTitle = "Hochschule Hof Stundenplan App"
    
    
    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)

        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccess()
        case EKAuthorizationStatus.authorized:
            // All good
            accessGranted = true
            showAlert = false
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            print("please give app permission to access calendar")
            showAlert = true
        @unknown default:
            print("this should not happen")
        }
    }
    
    //Kalender sollen erst geladen werden, wenn Nutzer zugriff erlaubt
    func getCalendars() -> [Calendar] {
        var calendars : [Calendar] = []
        //if allDone {
            let ekCalendars = self.eventStore.calendars(for: .event)
            for c in ekCalendars {
                calendars.append(Calendar(calendar: c))
                print("Titel:", c.title)
            }
        //}
        return calendars
    }
    
    //Kalender sollen erst geladen werden, wenn Nutzer zugriff erlaubt
    func getLectureCalendar() -> Calendar? {
        let calendars = getCalendars()
        for c in calendars {
            if c.calendar.title == calendarTitle {
                calendar = c.calendar
                return c
            }
        }
        //TO-DO: Error Handling, falls es diesen Kalender nicht gibt, weil der Nutzer die Kalender-Sync der Stundenplan-App nicht aktiviert hat
        //return Calendar(calendar: calendars[0].calendar)
        return nil
    }
    
    func returnCalendarCount() -> Int {
        let calendars = getCalendars()
        let count = calendars.count
        return count
    }
    
    func getLectureEvents() -> [Event]{
        var events : [Event] = []
        var ekEvents : [EKEvent] = []
        let calendar = getLectureCalendar()
        //calendar = getLectureCalendar()?.calendar
        //wenn calendar nicht null, dann sollen events aus diesem kalender gelden und zurückgegeben werden
        //if(calendar != nil) {
        if(accessGranted == true) {
            let oneDayAfter = Date(timeIntervalSinceNow: +1*24*3600)
            
            let predicate = self.eventStore.predicateForEvents(withStart:
                                                                Date(), end: oneDayAfter, calendars: [calendar!.calendar])
            
            ekEvents = eventStore.events(matching: predicate)
            for event in ekEvents {
                events.append(Event(event: event))
            }
        }
        //}
        return events
    }
    
    func requestAccess() {
        self.eventStore.requestAccess(to: .event, completion:
                    {[weak self] (granted: Bool, error: Error?) -> Void in
                        if granted {
                            print("Access granted")
                            self?.accessGranted = true
                        } else {
                            print("Access denied")
                            self?.accessGranted = false
                        }
                })
                print("Not Determined")
    }
}

struct Calendar : Identifiable {
    var id = UUID()
    var calendar : EKCalendar
}

struct Event : Identifiable {
    var id = UUID()
    var event : EKEvent
}
