//
//  IntentViewController.swift
//  ShowNextLectureUI
//
//  Created by Annika Pfosch on 26.10.20.
//

import Foundation
import IntentsUI
import IntentKit
import SwiftUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        // Do configuration here, including preparing views and calculating a desired size for presentation.
        if interaction.intentHandlingStatus == .success {
            if let _ = interaction.intentResponse as? ShowNextLectureIntentResponse {
                //let nextLectureView = UIHostingController(rootView: NextLectureView())
                //view.addSubview(nextLectureView.view)
                //completion(true, parameters, CGSize(width:  desiredSize.width, height: nextLectureView.frame.height))
                print("Jetzt View mit Raum und Zeit anzeigen")
                return
            }
        }
        completion(false, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}
