//
//  InvestmentVC.swift
//  EverythingInCoreData
//
//  Created by Saket Bhushan on 23/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit
import CoreData

class InvestmentVC: UIViewController {

    var fetchResultsVC : NSFetchedResultsController<Investment>!
    
    var coreDataManager = CoreDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let fetchRequest = Investment.getfetchRequest()
        self.fetchResultsVC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
        try self.fetchResultsVC.performFetch()
        } catch {
            print("something went wrong while fetching data")
        }
    }
}

extension InvestmentVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchResultsVC.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvestmentCell", for: indexPath)
        
        
        
        
        return cell
    }
    
    
}
