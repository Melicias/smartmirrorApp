//
//  ViewController.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 19/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var users: Array<User> = Array()
    
    
    @IBAction func addNewUser(_ sender: UIButton) {
        print("teste")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        db.collection("user").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let user = User(id: document.documentID,
                                    name: String(describing: document.data()["name"]),
                                    pinCode: String(describing: document.data()["pinCode"]),
                                    module: String(describing: document.data()["module"]));
                    self.users.append(user)
                    
                    let button = UIButton()
                    button.setTitle("btn 1", for: .normal)
                    button.translatesAutoresizingMaskIntoConstraints = false
                    button.frame = CGRect(x: 0, y: 0, width: 100, height: 100);
                    button.setImage(UIImage(named: "perfil1") , for: .normal)
                    let button2 = UIButton()
                    button2.setTitle("btn 1", for: .normal)
                    button2.translatesAutoresizingMaskIntoConstraints = false
                    button2.frame = CGRect(x: 0, y: 0, width: 100, height: 100);
                    button2.setImage(UIImage(named: "perfil2") , for: .normal)
                }
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "costumCell")
        cell?.textLabel?.text = "TESTE"
        
        return cell!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

