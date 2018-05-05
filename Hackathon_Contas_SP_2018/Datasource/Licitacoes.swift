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
    private var _dataPublicacao: Double!
    private var _dataProposta : Double!
    private var _material : String!
    private var _orgao : String!
    private var _valorEstimado : Double!
    private var _postRef : DatabaseReference!
    private var _views : Int!
    private var _star : Int!
    private var _link: String!

    var postKey: String {
        return _postKey
    }
    
    var nro: String {
        return _nro
    }
    
    var dataPublicacao: Double! {
        return _dataPublicacao
    }
    
    var dataProposta: Double! {
        return _dataProposta
    }
    
    var material: String! {
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

    var star: Int! {
        return _star
    }
    
    var link: String! {
        return _link
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
        
        if let dataPublicacao = postData["dataPublicacao"] as? Double {
            self._dataPublicacao = dataPublicacao
        }
        
        if let dataProposta = postData["dataProposta"] as? Double {
            self._dataProposta = dataProposta
        }

        if let material = postData["material"] as? String {
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
        
        if let star = postData["star"] as? Int {
            self._star = star
        }
        
        if let link = postData["link"] as? String {
            self._link = link
        }
        
        _postRef = DataService.ds.REF_LICITACOES.child(_postKey)
    }
    
}
