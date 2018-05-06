//
//  MaterialCell.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 06/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit

class MaterialCell: UITableViewCell {

    @IBOutlet weak var codigolbl: UILabel!
    @IBOutlet weak var materialLbl: UILabel!
    
    var material : Material!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(material: Material) {
        self.codigolbl.text = "\(material.codigo)"
        self.materialLbl.text = material.descricao
    }
}
