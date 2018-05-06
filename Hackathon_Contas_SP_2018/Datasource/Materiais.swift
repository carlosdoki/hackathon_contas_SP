//
//  Materiais.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 06/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import Firebase

class Materiais {
    private var _codigo_item : int4!
    private var _valor_unitario : double4!
    
    var codigo_item : int4 {
        return _codigo_item
    }
    
    var valor_unitario : double4 {
        return _valor_unitario
    }
    
    init(codigo_item: int4, valor_unitario: double4) {
        self._codigo_item = codigo_item
        self._valor_unitario = valor_unitario
    }
}
