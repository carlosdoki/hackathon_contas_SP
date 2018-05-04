//
//  TextField.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 04/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func setBottomLine(borderColor: UIColor) {
        
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        
        let borderLine = UIView()
        let height = 1.0
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
        
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
    
}
