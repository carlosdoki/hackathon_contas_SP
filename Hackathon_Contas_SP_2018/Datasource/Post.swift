//
//  Post.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 05/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//


import Foundation
import Firebase

class Post {
    private var _caption: String!
    private var _postKey: String!
    private var _postRef: DatabaseReference!
    private var _postedDate: Double!
    
    var caption: String {
        return _caption
    }
    
    var postKey: String {
        return _postKey
    }
    
    var postedDate: Double {
        return _postedDate
    }
    
    init(caption: String) {
        self._caption = caption
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let postedDate = postData["postedDate"] as? Double {
            self._postedDate = postedDate
        }
        
//        _postRef = DataService.ds.REF_POSTS.child(_postKey)
    }
}

