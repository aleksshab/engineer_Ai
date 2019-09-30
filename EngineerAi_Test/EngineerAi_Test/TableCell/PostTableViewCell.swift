//
//  PostTableViewCell.swift
//  EngineerAi_Test
//
//  Created by Александр  on 9/30/19.
//  Copyright © 2019 GoToInc. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var addTimeLabel: UILabel!
    @IBOutlet weak var activeStateSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupUIWith(model: Post) {
        postTitleLabel.text = model.title
        addTimeLabel.text = getDateStringFrom(date: model.createAt)
        activeStateSwitch.isOn = model.isActive
    }
    
    private func getDateStringFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
              dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
    @IBAction func swichValueChange(_ sender: UISwitch) {
        
        
    }
    

   
    
}
