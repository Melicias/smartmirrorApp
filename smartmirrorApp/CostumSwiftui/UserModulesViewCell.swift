//
//  UserModulesViewCell.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 01/12/2022.
//

import UIKit

class UserModulesViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with module: Module) {
        nameLabel.text = "Name: " + module.name
        widthLabel.text = "Width: " + String(module.size.width)
        heightLabel.text = "Height: " + String(module.size.height)
        xLabel.text = "X: " + String(module.position.x)
        yLabel.text = "Y: " + String(module.position.y)
    }

}
