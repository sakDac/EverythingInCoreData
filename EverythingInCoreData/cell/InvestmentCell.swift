//
//  InvestmentCell.swift
//  EverythingInCoreData
//
//  Created by Saket Bhushan on 23/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit

protocol InvestmentCellDelegate: class {
    func turnedOn(profile: Profile)
    func turedOff(profile: Profile)
}

class InvestmentCell: UITableViewCell {
    
    @IBOutlet weak var textLbl: UILabel!
    
    weak var friendsDelegate: FriendsDelegate?
    
    var profile: Profile?
    
    
    @IBOutlet weak var switchHandle: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(profile: Profile, isAFriend: Bool) {
        self.profile = profile
        print(" profile :: \(profile.name) :: \(isAFriend) ")
        self.switchHandle.setOn(isAFriend, animated: true)
        
    }
    
    
    @IBAction func switchClick(_ sender: UISwitch) {
        if sender.isOn {
            self.friendsDelegate?.turnedOn(profile: self.profile!)
        } else {
            self.friendsDelegate?.turedOff(profile: self.profile!)
        }
    }
    
    
}
