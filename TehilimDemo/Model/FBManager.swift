//
//  FBManager.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 16/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FBManager: NSObject {
    static let manager = FBManager()
    
    var rootRef: FIRDatabaseReference!
    var myDedicationsRef: FIRDatabaseReference!
    var dedicationsRef: FIRDatabaseReference!
    
    override init() {
        rootRef = FIRDatabase.database().reference()
        myDedicationsRef = rootRef.child(FBManager.MY_DEDICATIONS)
        dedicationsRef = rootRef.child(FBManager.DEDICATION)
        
        super.init()
    }
    
    
    func readMyDedication(with completion : @escaping ([String]?)->Void){
        
        //myDedicationsRef.removeAllObservers()
        
        var text1 = ""
        var text2 = ""
        var text3 = ""
        var text4 = ""
        var text5 = ""
        var text6 = ""
        self.myDedicationsRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let val = snapshot.value as? NSDictionary else{
                return
            }
            
            text1 = val["1"] as? String ?? ""
            text2 = val["2"] as? String ?? ""
            text3 = val["3"] as? String ?? ""
            text4 = val["4"] as? String ?? ""
            text5 = val["5"] as? String ?? ""
            text6 = val["6"] as? String ?? ""
            
            
            completion([text1,text2,text3,text4,text5,text6])
            
        })
    }

}

extension FBManager {
    static let MY_DEDICATIONS: String = "my_dedication"
    static let DEDICATION: String = "dedication"
}
