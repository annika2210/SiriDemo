//
//  AddVoiceShortcutView.swift
//  SiriDemo
//
//  Created by Annika Pfosch on 27.10.20.
//

import SwiftUI
import IntentsUI

/// Diese View repräsentiert einen ViewController
struct AddVoiceShortcutView: UIViewControllerRepresentable {
    
    
    //MARK: - COORDINATOR
    func makeCoordinator() -> Coordinator {
        return Coordinator(context: self)
    }

    class Coordinator: NSObject, INUIAddVoiceShortcutViewControllerDelegate {
        let context: AddVoiceShortcutView
        
        init(context: AddVoiceShortcutView) {
            self.context = context
        }
        
        
        //MARK: INUIAddVoiceShortcutViewControllerDelegate
        func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
            context.presentationMode.wrappedValue.dismiss()
        }
        
        func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
            context.presentationMode.wrappedValue.dismiss()
        }
    }
    
    //MARK: - VIEWCONTROLLER
    @Environment(\.presentationMode) var presentationMode
    var addVoiceShortcutVC: INUIAddVoiceShortcutViewController
    
    ///kreiert den View Controller und konfiguriert initialen Zustand
    func makeUIViewController(context: Context) -> INUIAddVoiceShortcutViewController {
        self.addVoiceShortcutVC.delegate = context.coordinator
        return self.addVoiceShortcutVC
    }
    
    ///Aktualisiert den Status des angegebenen Viewcontrollers mit neuen Informationen von SwiftUI.
    func updateUIViewController(_ uiViewController: INUIAddVoiceShortcutViewController, context: Context) {
        
    }
    
}

