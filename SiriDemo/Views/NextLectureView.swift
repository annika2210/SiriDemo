//
//  NextLectureView.swift
//  SiriDemo
//
//  Created by Annika Pfosch on 26.10.20.
//

import SwiftUI

struct NextLectureView: View {
    @ObservedObject var vm : ContentViewModel
    var body: some View {
        Text("Name: \(vm.firstEvent?.event.title ?? "Kein Titel")")
        Text("Name: \(vm.firstEvent?.event.location ?? "Kein Ort")")
        Text("Name: \(vm.firstEvent?.event.startDate.description ?? "Keine Zeit")")
    }
}

//struct NextLectureView_Previews: PreviewProvider {
//    static var previews: some View {
//        NextLectureView()
//    }
//}
