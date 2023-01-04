//
//  AddNewModuleTableViewController.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 25/12/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class AddNewModuleTableViewController: UITableViewController {

    var user: User!
    var module: Module!
    var isUpdate: Bool = false
    var rowIndex:Int!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = module.name
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        // SIZE altura largura X Y e os restante dentro do config
        return (4 + self.module.config.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FieldToAddModule", for: indexPath) as! FieldToAddModuleViewCell
        cell.selectionStyle = .none
        // Fetch the data for the row.
        switch(indexPath.row){
        case 0:
            cell.update(name: "Width", value: String(module.size.width))
            cell.textfield.isUserInteractionEnabled = false
        case 1:
            cell.update(name: "Height", value: String(module.size.height))
            cell.textfield.isUserInteractionEnabled = false
        case 2:
            cell.update(name: "X", value: String(module.position.x))
            cell.textfield.keyboardType = UIKeyboardType.numberPad
            
        case 3:
            cell.update(name: "Y", value: String(module.position.y))
            cell.textfield.keyboardType = UIKeyboardType.numberPad
            
        default:
            let nb = indexPath.row - 4
            cell.update(name: Array(self.module.config.keys)[nb], value: Array(self.module.config.values)[nb])
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "unwindFromAddModule" else { return }
        
        var cells = getAllCells()
        //2 = X
        module.position.x = Int((cells[2] as! FieldToAddModuleViewCell).textfield.text ?? "") ?? 0
        //3 = Y
        module.position.y = Int((cells[3] as! FieldToAddModuleViewCell).textfield.text ?? "") ?? 0
       
        //configs remove first 4 elements so it only leaves the config cells
        cells.removeFirst(4)
        for cell in cells{
            module.config.updateValue((cell as! FieldToAddModuleViewCell).textfield.text ?? "", forKey: (cell as! FieldToAddModuleViewCell).label.text ?? "")
        }
    
        
        if isUpdate {
            let mod : Module = self.user.module[self.rowIndex]
            self.user.module[self.rowIndex] = module
            Firestore.firestore().collection("user").document(self.user.id!).updateData([
                "module": modulesDataToSend(modules: self.user.module)
            ]) { (error) in
                if let error = error {
                    // An error occurred
                    self.user.module[self.rowIndex] = mod
                    print("Error updating the user modulos: \(error)")
                } else {
                    // Update the table vie
                }
            }
        }else{
            //add to firebase the new module
            self.user.module.append(module)
            Firestore.firestore().collection("user").document(self.user.id!).updateData([
                "module": modulesDataToSend(modules: self.user.module)//FieldValue.arrayUnion([self.module.dataToPass])
            ])
        }
    }
    
    func modulesDataToSend(modules: Array<Module>) -> [[String:Any]] {
        var mods: [[String:Any]] = []
        for module in modules{
            mods.append(module.dataToPass)
        }
        
        return mods
    }
    
    /*func addUser(user: User) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("user")
        collectionRef.addDocument(data: user.dataToPass)
    }*/
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
    
    func getAllCells() -> [UITableViewCell] {
        var cells = [UITableViewCell]()
        // assuming tableView is your self.tableView defined somewhere
        for i in 0...tableView.numberOfSections-1
        {
            for j in 0...tableView.numberOfRows(inSection:i)-1
            {
                if let cell = tableView.cellForRow(at: NSIndexPath(row: j, section: i) as IndexPath) {
                   cells.append(cell)
                }
            }
        }
        return cells
     }

}
