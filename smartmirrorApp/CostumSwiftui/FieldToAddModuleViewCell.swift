//
//  FieldToAddModuleViewCell.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 26/12/2022.
//

import UIKit

class FieldToAddModuleViewCell: UITableViewCell {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(name : String, value : String) {
        label.text = name
        textfield.text = value
    }

}
