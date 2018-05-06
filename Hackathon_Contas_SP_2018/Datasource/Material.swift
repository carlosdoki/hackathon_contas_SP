//
//  Material.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 06/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import Firebase

class Material {
    private var _codigo : Int!
    private var _descricao : String!
    private var _postKey: String!
    private var _postRef : DatabaseReference!
    
    var codigo: Int {
        return _codigo
    }
    
    var descricao: String {
        if _descricao == nil {
            _descricao = ""
        }
        return _descricao
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(codigo: Int, descricao: String) {
        self._codigo = codigo
        self._descricao = descricao
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let codigo = postData["itemOC"] as? Int {
            self._codigo = codigo
        }
        
        if let descricao = postData["descricao"] as? String {
            self._descricao = descricao
        }
        
        _postRef = DataService.ds.REF_FORNECEDORES.child(_postKey)
    }
}
