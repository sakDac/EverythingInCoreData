//
//  InvestmentCell.swift
//  EverythingInCoreData
//
//  Created by Saket Bhushan on 23/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit

protocol InvestmentCellDelegate: class {
    func turnedOn(investment: Investment)
    func turedOff(investment: Investment)
}

class InvestmentCell: UITableViewCell {
    
    @IBOutlet weak var textLbl: UILabel!
    
    weak var investmentDelegate: InvestmentCellDelegate?
    
    var investment: Investment?
    
    
    @IBOutlet weak var switchHandle: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(investment: Investment, isTaken: Bool) {
        self.investment = investment
        self.switchHandle.setOn(isTaken, animated: true)
    }
    
    
    @IBAction func switchClick(_ sender: UISwitch) {
        if sender.isOn {
            self.investmentDelegate?.turnedOn(investment: self.investment!)
        } else {
            self.investmentDelegate?.turedOff(investment: self.investment!)
        }
    }
    
    
}
