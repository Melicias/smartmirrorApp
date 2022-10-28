//
//  createNewUserViewController.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 26/10/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class createNewUserViewController: UITableViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldName.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }

        let name = textFieldName.text ?? ""
        let pinCode = textFieldPin.text ?? ""
        let aes128 = Encrypt().encrypt(string: pinCode)
        
        let user = User(id: "", name: name, pinCode: aes128?.base64EncodedString() ?? "",img: "")
        //let decrypt = Encrypt().decrypt(data: Data(base64Encoded: user.pinCode))
        addUser(user: user);
    }
    
    func addUser(user: User) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("user")
        collectionRef.addDocument(data: user.dataToPass)
    }
    
}

