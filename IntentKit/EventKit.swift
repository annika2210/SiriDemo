// Helper function for showing UIAlert prompts
func showMessagePrompt(_ title: String, message: String) {
    let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))

    self.present(alert, animated: true, completion: nil)
}

/********************/

// Calendars
let calendar = Calendar.autoupdatingCurrent
let eventStore = EKEventStore()

// Ask for Calendar access
func requestAccessToCalendar() {
    self.eventStore.requestAccess(to: EKEntityType.event, completion: {
        (accessGranted: Bool, error: NSError?) in

        if accessGranted == true {
            DispatchQueue.main.async(execute: {
                self.loadCalendars()
                self.refreshTableView()
            })
        } else {
            DispatchQueue.main.async(execute: {
                self.showMessagePrompt("Permission Error", message: "Needs calendar permission.")
            })
        }
    } as! EKEventStoreRequestAccessCompletionHandler)
}

// Check calendar authorization status
func checkCalendarAuthorizationStatus() {
    let status = EKEventStore.authorizationStatus(for: EKEntityType.event)

    switch (status) {
    case EKAuthorizationStatus.notDetermined:
        // This happens on first-run
        requestAccessToCalendar()
    case EKAuthorizationStatus.authorized:
        // All good
    case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
        // We need to help them give us permission
        self.showMessagePrompt("Permission Error", message: "Needs calendar permission.")
    }
}

// Get all events
func getEvents() -> [EKEvent] {
    var allEvents: [EKEvent] = []

    // calendars
    let calendars = self.eventStore.calendars(for: .event)

    // iterate over all selected calendars
    for (_, calendar) in calendars.enumerated() where isCalendarSelected(calendar.calendarIdentifier) {

        // predicate for today (start to end)
        let predicate = self.eventStore.predicateForEvents(withStart: self.initialDates.first!, end: self.initialDates.last!, calendars: [calendar])

        let matchingEvents = self.eventStore.events(matching: predicate)

        // iterate through events
        for event in matchingEvents {
            allEvents.append(event)
        }
    }

    return allEvents
}
