//
//  PostsVC.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 05/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class PostsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    @IBOutlet weak var postTbl: UITableView!
    
    var posts = [Post]()
    var postKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postTbl.delegate = self
        postTbl.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        if let cell = postTbl.dequeueReusableCell(withIdentifier: "PostCell") as? PostsCell {
            cell.configureCell(post: post)
            return cell
        } else {
            return PostsCell()
        }
        
        
    }
}
