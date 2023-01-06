//
//  UITabBarControllerMainViewController.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 01/12/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class UITabBarControllerMainViewController: UITabBarController {

    var user: User!
    var modules: Array<Module> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.setHidesBackButton(true, animated: false)

        getModules()

        self.title = ""
        
        let usermodules = self.viewControllers![0] as! UserModulesTableViewController
        usermodules.title = "My widgets"
        usermodules.user = user
        
        let modu = self.viewControllers![1] as! ModulesTableViewController
        usermodules.title = "My widgets"
        modu.modules = modules
        modu.user = user
        
        let userpic = self.viewControllers![2] as! SelfieViewController
        userpic.user = user
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func getModules(){
        let db = Firestore.firestore()
        db.collection("widget").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.modules = Array()
                for document in querySnapshot!.documents {
                    do {
                        let module = try document.data(as:Module.self)
                        self.modules.append(module)
                        print(module)
                    }
                    catch {
                      print (error)
                    }
                }
                let modu = self.viewControllers![1] as! ModulesTableViewController
                modu.modules = self.modules
            }
        }
    }
    

}
