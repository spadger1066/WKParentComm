//
//  InterfaceController.swift
//  WKParentCommWatch Extension
//
//  Created by Stephen on 16/10/2015.
//  Copyright © 2015 lumiator.technology.com. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController {
    
    @IBOutlet var lblInfo: WKInterfaceLabel!
    @IBOutlet var lblInput: WKInterfaceLabel!
    
    var input:Float!
    
    @IBAction func inputChanged(value: Float) {
        let strValue = NSString(format: "%.0f", value) as String
        lblInput.setText("\(strValue)")
        input = value
    }
    
    @IBAction func getInfo() {
        if WCSession.defaultSession().reachable == true {
            let session = WCSession.defaultSession()
            session.sendMessage(["input" : input], replyHandler: { reply in
                let average = reply["average"] as! Float
                self.lblInfo.setText("\(average)")
                }, errorHandler: { error in
                    print("error: \(error)")
            })
        }
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
