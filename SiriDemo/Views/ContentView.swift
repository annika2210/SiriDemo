//
//  ContentView.swift
//  SiriDemo
//
//  Created by Annika Pfosch on 26.10.20.
//

import SwiftUI
import IntentKit
import Intents
import IntentsUI

struct ContentView: View {
    @ObservedObject var vm : ContentViewModel
    @State private var showingAlert = CalendarAccess.sharedInstance.showAlert
    var converter = Converter()
    
    var body: some View {
        let testIntent1 = ShowNextLectureIntent()
        testIntent1.suggestedInvocationPhrase = "Meine Vorlesung?"
        
        return VStack() {
            IntentView(intent: testIntent1)
                .padding()
            Text("Kalender").font(.largeTitle).padding()
                
            .alert(isPresented: $showingAlert) {
                       Alert(title: Text("Authorization"), message: Text("We need to get your authorization in order to continue. Please go to Settings."), dismissButton: .default(Text("Got it!")))
                   }
            VStack(alignment: .leading) {
                HStack {
                    Text("Name").bold()
                    Text(vm.lectureCalendar?.calendar.title ?? "Kein Titel").multilineTextAlignment(.leading)
                }
            }
            Text("Nächste Vorlesung").font(.largeTitle).padding()
            VStack(alignment: .leading){
                HStack(spacing:10) {
                    Text("Titel").bold()
                    Text(vm.firstEvent?.event.title ?? "Kein Titel").multilineTextAlignment(.leading)
                }
                HStack(spacing: 10) {
                    Text("Ort").bold()
                    Text(converter.convertLocation2Room(room: vm.firstEvent?.event.location?.description ?? "Kein Ort")
                    )
                }
                HStack(spacing: 10) {
                    Text("Zeit").bold()
                    if(vm.firstEvent?.event != nil) {
                        Text("\(converter.convertDate(date: vm.firstEvent!.event.startDate.description)) Uhr")
                    } else {
                        Text("Keine Zeitangabe")
                    }
                }
            }
        }
       .onAppear() {
        //reload funktioniert nicht
            self.vm.reload()
        }
    }
}

