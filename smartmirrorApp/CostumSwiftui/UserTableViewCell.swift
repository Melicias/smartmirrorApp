//
//  UserTableViewCell.swift
//  smartmirrorApp
//
//  Created by Francisco Melicias on 26/10/2022.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var uiLabel: UILabel!
    @IBOutlet weak var UiImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func update(with user: User) {
        UiImage.image = UIImage(named:user.img ?? "perfil1")
        uiLabel.text = user.name
    }

}
