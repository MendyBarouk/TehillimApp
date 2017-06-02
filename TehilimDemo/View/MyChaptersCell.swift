//
//  MyChaptersCell.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 14/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit

class MyChaptersCell: UITableViewCell {

    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(withTehilimCore tehilimCore: TehilimCore) {
        if let date = tehilimCore.date {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en")
            formatter.dateStyle = .long
            formatter.calendar = Calendar(identifier: .hebrew)
            birthdayLabel.text = "birthday".localizedString + formatter.string(from: date as Date)
        } else {
            birthdayLabel.text = "chapter".localizedString + "\(tehilimCore.perek)"
        }
        if let name = tehilimCore.name {
            nameLabel.text = "name".localizedString + name
        }
    }

}
