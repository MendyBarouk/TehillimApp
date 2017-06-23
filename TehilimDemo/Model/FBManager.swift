//
//  FBManager.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 16/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension Notification.Name{
    static var dedicationFetched : Notification.Name{
        get{
            return Notification.Name(rawValue: "dedications_fetched_notification")
        }
    }
}

class FBManager: NSObject {
    static let manager = FBManager()
    
    var rootRef: DatabaseReference!
    var myDedicationsRef: DatabaseReference!
    var dedicationsRef: DatabaseReference!
    
    override init() {
        rootRef = Database.database().reference()
        myDedicationsRef = rootRef.child(FBManager.MY_DEDICATIONS)
        dedicationsRef = rootRef.child(FBManager.DEDICATION)
        
        super.init()
        
        readMyDedication()
    }
    
    var fetchedDedications : [Dedication]? = []{
        didSet{
            NotificationCenter.default.post(name: .dedicationFetched, object: self)
        }
    }
    
    func readMyDedication(){
        
        self.myDedicationsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let val = snapshot.value as? [String:[String:Any]] else {
                return
            }
            
            var arr : [Dedication] = []
            let values = Array(val.values)
            for dict in values{
                let d = Dedication(dict)
                if d.isValid(){
                    arr.append(d)
                }
            }
            
            self.fetchedDedications = arr
            
            
        })
    }

}

extension FBManager {
    static let MY_DEDICATIONS: String = "my_dedication"
    static let DEDICATION: String = "dedication"
}
