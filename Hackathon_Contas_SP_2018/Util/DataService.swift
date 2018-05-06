//
//  DataService.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 05/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//


import Foundation
import Firebase
import SwiftKeychainWrapper

let DB_BASE = Database.database().reference()
let STORAGE_BASE = Storage.storage().reference()

class DataService {
    static let ds = DataService()
    
    // DB References
    private var _REF_BASE = DB_BASE
    //private var _REF_POSTS = DB_BASE.child("licitacao").child("post")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_LICITACOES = DB_BASE.child("licitacao")
    
    // Storage References
    private var _REF_POST_IMAGES=STORAGE_BASE.child("post-pics")
    
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
//    var REF_POSTS: DatabaseReference {
//        return _REF_POSTS
//    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }

    var REF_LICITACOES: DatabaseReference {
        return _REF_LICITACOES
    }

    var REF_POST_IMAGES: StorageReference {
        return _REF_POST_IMAGES
    }
    
    var REF_USER_CURRENT: DatabaseReference {
        let uid = KeychainWrapper.standard.string(forKey: KEY_UID)
        let user = REF_USERS.child(uid!)
        return user
    }
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, String>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
}

