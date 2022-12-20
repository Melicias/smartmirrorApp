//
//  pinCodeController.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 27/10/2022.
//

import UIKit

class pinCodeController: UIViewController {
    var user: User!
    
    @IBOutlet weak var labelForName: UILabel!
    @IBOutlet weak var pinCodeLabel: UITextField!
    @IBOutlet weak var wrongpinLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelForName.text = user.name
        // Do any additional setup after loading the view.
        //https://stackoverflow.com/questions/8066525/prevent-segue-in-prepareforsegue-method
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToTabController") {
            let secondView = segue.destination as! UITabBarControllerMainViewController
            secondView.user = user
            //let thirdView = secondView.customizableViewControllers![0] as! UINavigationController
            //let fourthView = thirdView.visibleViewController as! UserModulesTableViewController
            //let object = sender as! User
            //fourthView.user = user
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard identifier == "segueToTabController" else { return true}

        self.wrongpinLabel.isHidden = true
        if self.pinCodeLabel.text?.isEmpty == true {
            self.pinCodeLabel.layer.borderColor = UIColor.red.cgColor
            self.pinCodeLabel.layer.borderWidth = 1.0
            self.wrongpinLabel.text = "Must type the pin code"
            self.wrongpinLabel.isHidden = false
            return false
        }else{
            self.pinCodeLabel.layer.borderWidth = 0.0
            self.pinCodeLabel.layer.borderColor = UIColor.black.cgColor
        }
        
        if Encrypt().encrypt(string: pinCodeLabel.text!)?.base64EncodedString() == user.pinCode {
            return true
        }else{
            self.pinCodeLabel.layer.borderColor = UIColor.red.cgColor
            self.pinCodeLabel.layer.borderWidth = 1.0
            self.wrongpinLabel.text = "Wrong pin code"
            self.wrongpinLabel.isHidden = false
        }
        return false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
