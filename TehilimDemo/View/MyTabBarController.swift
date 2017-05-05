//
//  MyTabBarController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 27/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let item1 = self.tabBar.items?[0], let item2 = self.tabBar.items?[1] {
            item1.title = "daily".localizedString
            item2.title = "everything".localizedString
        }
        
        self.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 16)], for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
