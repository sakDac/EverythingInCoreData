//
//  ProfileTableViewController.swift
//  EverythingInCoreData
//
//  Created by saket bhushan on 23/10/18.
//  Copyright © 2018 saket bhushan. All rights reserved.
//

import UIKit
import CoreData

class ProfileTableViewController: UITableViewController {

    var investmentID = ""
    var fetchResultController : NSFetchedResultsController<Investment>!
    var coreDataManager = CoreDataManager.shared
    
    var profileList = [Profile]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
       let fetchRequest = Investment.getfetchRequest()
       fetchRequest.sortDescriptors = [.init(key: "company", ascending: true)]
       fetchRequest.predicate = NSPredicate(format: "id == %@", self.investmentID)
        
       self.fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.coreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try self.fetchResultController.performFetch()
            self.fetchResultController.fetchedObjects?.first?.buyer?.forEach({ (buyer) in
                let profile = buyer as! Profile
                self.profileList.append(profile)
            })
//            self.tableView.reloadData()
            
        } catch  {
            print(" error in fetching investments")
        }
    }

    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvestmentCell", for: indexPath) as! InvestmentCell
        let profile = profileList[indexPath.row]
        cell.textLbl.text = "Name : " + profile.name!
        cell.investmentDelegate = self
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileTableViewController : InvestmentCellDelegate {
    func turnedOn(investment: Investment) {
        
    }
    
    func turedOff(investment: Investment) {
        
    }
    
    
}
