//
//  ModulesViewCell.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 08/12/2022.
//

import UIKit

class ModulesViewCell: UITableViewCell {

    @IBOutlet weak var moduleImage: UIImageView!
    @IBOutlet weak var moduleHeight: UILabel!
    @IBOutlet weak var moduloWidth: UILabel!
    @IBOutlet weak var moduleName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func update(with module: Module) {
        moduleName.text = module.name
        moduleName.font = UIFont.boldSystemFont(ofSize: 18)
        moduloWidth.text = "Width: " + String(module.size.width)
        moduleHeight.text = "Height: " + String(module.size.height)
        moduleImage.image = UIImage(named:String(module.name) ?? "default")
    }
}
