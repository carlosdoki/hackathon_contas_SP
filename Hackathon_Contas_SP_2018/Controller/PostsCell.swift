//
//  PostsCell.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 05/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class PostsCell: UITableViewCell {
    
    @IBOutlet weak var mensagemLbl: UILabel!
    @IBOutlet weak var dataLbl: UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: Post) {
        self.mensagemLbl.text = post.caption
        self.dataLbl.text = "\(post.postedDate)"
    }
}
