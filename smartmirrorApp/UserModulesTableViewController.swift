//
//  UsersTableViewController.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 26/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class UserModulesTableViewController: UITableViewController {
    
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 120.0
        tableView.estimatedRowHeight = 120.0
        
        if let tabController = self.parent as? UITabBarControllerMainViewController {
            tabController.navigationItem.title = "My widgets"
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return user.module.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Step 1: Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserModulesCell", for: indexPath) as! UserModulesViewCell

        //Step 2: Fetch model object to display
        let module = user.module[indexPath.row]

        //Step 3: Configure cell
        cell.update(with: module)
        cell.showsReorderControl = false
        
        //Step 4: Return cell
        return cell
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in

            //self.items.remove(at: indexPath.row)
            let module=self.user.module[indexPath.row].dataToPass
            self.user.module.remove(at: indexPath.row)
                        
            Firestore.firestore().collection("user").document(self.user.id!).updateData([
                "module": Module.modulesDataToSend(modules: self.user.module)
            ]) { (error) in
                if let error = error {
                    // An error occurred
                    print("Error updating the user modulos: \(error)")
                } else {
                    // Delete the item from the list
                    //self.user.module.remove(at: indexPath.row)
                    // Update the table view
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                
                // Call the completion handler
                completion(true)
            }
        }
        deleteAction.image = UIImage(systemName: "trash")

        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToEditModule", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToEditModule") {
            let secondView = segue.destination as! AddNewModuleTableViewController
            let rowIndex = sender as! Int
            secondView.module = user.module[rowIndex]
            secondView.user=self.user
            secondView.isUpdate=true
            secondView.rowIndex = rowIndex
        }
    }
    
    
}
