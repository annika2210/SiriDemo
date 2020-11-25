//
//  IntentView.swift
//  SiriDemo
//
//  Created by Annika Pfosch on 27.10.20.
//

import SwiftUI
import IntentsUI
import IntentKit

//IntentView ruft IntentButton mit Intent, VC und Content auf
struct IntentView: View {
    @State var voiceShortcutVC: UIViewController?
    @State var isSheetPresented = false
    
    var intent: INIntent
    
    var body: some View {
        IntentButton(intent: self.intent, voiceShortcutVC: $voiceShortcutVC, isSheetPresented: $isSheetPresented)
            .sheet(isPresented: $isSheetPresented, content: sheetContent)
    }
    ///ViewBuilder: Ein benutzerdefiniertes Parameterattribut, das Views aus Closures erstellt.
    ///Normalerweise verwenden Sie ViewBuilder als Parameterattribut für untergeordnete Ansichten erzeugende Abschlussparameter, sodass diese Schließungen mehrere untergeordnete Ansichten bereitstellen können.
    @ViewBuilder func sheetContent() -> some View {

///content des sheets, das aufgeht, wenn nutzer auf button klickt
        if self.voiceShortcutVC is INUIAddVoiceShortcutViewController  {
            AddVoiceShortcutView(addVoiceShortcutVC: self.voiceShortcutVC as! INUIAddVoiceShortcutViewController)
        }
        else if self.voiceShortcutVC is INUIEditVoiceShortcutViewController {
            EditVoiceShortcutView(editVoiceShortcutVC: self.voiceShortcutVC as! INUIEditVoiceShortcutViewController)
        }
        ///voiceShortCutVC == nil bei 1. Klick
        else {
            AddVoiceShortcutView(addVoiceShortcutVC: INUIAddVoiceShortcutViewController(shortcut: INShortcut(intent: self.intent)!))
            //EmptyView()
        }
    }

}

struct IntentView_Previews: PreviewProvider {
    static var previews: some View {
        let testIntent = ShowNextLectureIntent()
        testIntent.suggestedInvocationPhrase = "Remember mine position"
        return IntentView(intent: testIntent)
    }
}
