//
//  CircleView.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 04/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }
}
