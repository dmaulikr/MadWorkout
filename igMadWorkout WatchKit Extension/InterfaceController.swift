//
//  InterfaceController.swift
//  igMadWorkout WatchKit Extension
//
//  Created by Moncef Hireche on 17-07-17.
//  Copyright © 2017 Moncef Hireche. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    // ========================================================================= Outlets
    @IBOutlet var table: WKInterfaceTable!
    // ========================================================================= Attributs
    var data: [String : String] = [:]
    var dates: [String] = []
    var workouts: [String] = []
    //--------------------
    var session: WCSession!
    //--------------------
    func userDefaultManager() {
        if UserDefaults.standard.object(forKey: "data") == nil {
            UserDefaults.standard.set(data, forKey: "data")
        } else {
            data = UserDefaults.standard.object(forKey: "data") as! [String : String]
        }
    }
    //--------------------
    func tableRefresh() {
        table.setNumberOfRows(data.count, withRowType: "row")
        
        for index in 0..<table.numberOfRows {
            let row = table.rowController(at: index) as! TableRowController
            row.dates.setText(dates[index])
        }
    }
    //--------------------
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    //--------------------
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        //
        if WCSession.isSupported() {
            session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        //
        userDefaultManager()
        //
        self.dates = Array(data.keys)
        self.workouts = Array(data.values)
        self.tableRefresh()
    }
    //
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    //
    @available(watchOS 2.2, *)
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //..code
    }
    //
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let value = message["Message"] as? [String : String]
        //
        DispatchQueue.main.async { () -> Void in
            self.data = value!
            UserDefaults.standard.set(self.data, forKey: "data")
            self.dates = Array(value!.keys)
            self.workouts = Array(value!.values)
            self.tableRefresh()
        }
//        replyHandler(["Message" : conversation])
    }
    //
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        self.pushController(withName: "page2", context: ["workout" : workouts[rowIndex]])
    }
}
