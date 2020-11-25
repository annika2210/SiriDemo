//
//  IntentButton.swift
//  SiriDemo
//
//  Created by Annika Pfosch on 27.10.20.
//

import SwiftUI
import IntentsUI

struct IntentButton: UIViewRepresentable {
    
    var intent: INIntent

    @Binding var voiceShortcutVC: UIViewController?
    @Binding var isSheetPresented: Bool

    
    //MARK: - VIEW
//    public var intent: DoSomethingIntent {
//        let testIntent = DoSomethingIntent()
//        testIntent.suggestedInvocationPhrase = "Remember mine position"
//        return testIntent
//    }
    
    func makeUIView(context: Context) -> INUIAddVoiceShortcutButton {
        let button = INUIAddVoiceShortcutButton(style: .whiteOutline)
        button.shortcut = INShortcut(intent: intent)
        button.delegate = context.coordinator
        return button
    }
    
    func updateUIView(_ uiView: INUIAddVoiceShortcutButton, context: Context) {
        
    }
    
    //MARK: - COORDINATOR

    func makeCoordinator() -> Coordinator {
        return Coordinator(context: self)
    }
    
    class Coordinator: NSObject, INUIAddVoiceShortcutButtonDelegate {
        var context: IntentButton
        
        init(context: IntentButton) {
            self.context = context
        }
        
        //MARK: VOICE SHORTCUT DELEGATE
        func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
            self.context.voiceShortcutVC = addVoiceShortcutViewController
            self.context.isSheetPresented = true
        }
        
        func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
            self.context.voiceShortcutVC = editVoiceShortcutViewController
            self.context.isSheetPresented = true
        }
    }
    
}


