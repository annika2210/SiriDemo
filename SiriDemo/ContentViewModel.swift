//
//  ContentViewModel.swift
//  SiriDemo
//
//  Created by Annika Pfosch on 26.10.20.
//

import Foundation
import EventKit
import SwiftUI
import IntentKit
import IntentsUI
import Intents

class ContentViewModel : ObservableObject {
    
    @Published var calendars : [Calendar] = []
    @Published var events : [Event] = []
    @Published var firstEvent: Event?
    @Published var lectureCalendar : Calendar?
    
    init() {
            calendars = CalendarAccess.sharedInstance.getCalendars()
            events = CalendarAccess.sharedInstance.getLectureEvents()
            firstEvent = CalendarAccess.sharedInstance.getLectureEvents().first
            lectureCalendar = CalendarAccess.sharedInstance.getLectureCalendar()
    }
    
    //funktioniert nicht
    func reload() {
            CalendarAccess.sharedInstance.calendar = nil
            //CalendarAccess.sharedInstance.calendar = CalendarAccess.sharedInstance.getLectureCalendar()?.calendar
            calendars = []
            events = []
            calendars = CalendarAccess.sharedInstance.getCalendars()
            events = CalendarAccess.sharedInstance.getLectureEvents()
    }
}
