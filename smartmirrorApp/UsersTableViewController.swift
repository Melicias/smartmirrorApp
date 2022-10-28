//
//  UsersTableViewController.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 26/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class UsersTableViewController: UITableViewController {
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var users: Array<User> = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 120.0
        tableView.estimatedRowHeight = 120.0
        
        getUsers()
    }
    
    func getUsers(){
        
        let db = Firestore.firestore()
        db.collection("user").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.users = Array()
                var i: Int = 1
                for document in querySnapshot!.documents {
                    do {
                        let user = try document.data(as:User.self)
                        user.img = "perfil\(i)"
                        self.users.append(user)
                    }
                    catch {
                      print (error)
                    }
                    i+=1
                }
                if(self.users.count >= 5){
                    self.addButton.isHidden = true
                }
                self.tableView.reloadData()
            }
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
            return users.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Step 1: Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserTableViewCell

        //Step 2: Fetch model object to display
        let user = users[indexPath.row]

        //Step 3: Configure cell
        cell.update(with: user)
        cell.showsReorderControl = true

        //Step 4: Return cell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "segueToPin", sender: users[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToPin") {
            let secondView = segue.destination as! pinCodeController
            let object = sender as! User
            secondView.user = object
        }
    }
    
    
    @IBAction func unwindToUsersTableView(segue: UIStoryboardSegue) {
       getUsers()
    }
    
}
