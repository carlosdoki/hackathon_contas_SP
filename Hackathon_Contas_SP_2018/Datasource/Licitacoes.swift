//
//  Licitacoes.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 05/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import Foundation
import Firebase

class Licitacoes {
    private var _postKey: String!
    private var _nro : String!
    private var _dataEncerramento : String!
    private var _material : Int!
    private var _orgao : String!
    private var _valorEstimado : Double!
    private var _situacao: String!
    private var _postRef : DatabaseReference!
    private var _views : Int!
    private var _star : Double!
    private var _link: String!

    var postKey: String {
        return _postKey
    }
    
    var nro: String {
        if _nro != nil {
            return _nro
        } else {
            return ""
        }
    }

    var dataEncerramento: String! {
        return _dataEncerramento
    }
    
    var material: Int! {
        return _material
    }
    
    var orgao: String! {
        return _orgao
    }
    
    var valorEstimado: Double {
        return _valorEstimado
    }
    
    var views: Int! {
        return _views
    }

    var star: Double! {
        return _star
    }
    
    var link: String! {
        return _link
    }
    
    var situacao: String! {
        return _situacao
    }
    
    init(nro: String) {
        self._nro = nro
//        self._imageUrl = imageUrl
//        self._likes = likes
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let nro = postData["nro"] as? String {
            self._nro = nro
        }
        
        if let dataEncerramento = postData["dataEncerramento"] as? String {
            self._dataEncerramento = dataEncerramento
        }

        if let material = postData["material"] as? Int {
            self._material = material
        }
        
        if let orgao = postData["orgao"] as? String {
            self._orgao = orgao
        }
        
        if let valorEstimado = postData["valorEstimado"] as? Double {
            self._valorEstimado = valorEstimado
        }
        
        if let views = postData["views"] as? Int {
            self._views = views
        }
        
        if let star = postData["star"] as? Double {
            self._star = star
        }
        
        if let link = postData["link"] as? String {
            self._link = link
        }
        
        if let situacao = postData["situacao"] as? String {
            self._situacao = situacao
        }
        
        _postRef = DataService.ds.REF_LICITACOES.child(_postKey)
    }
    
    func adjustLikes() {
        _views = _views + 1
        _postRef.child("views").setValue(_views)
    }
}
