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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.performSegue(withIdentifier: "segueToPin", sender: users[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToPin") {
            let secondView = segue.destination as! pinCodeController
            let object = sender as! User
            secondView.user = object
        }
    }
    
    
}
