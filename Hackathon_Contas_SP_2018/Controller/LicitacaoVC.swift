//
//  LicitacaoVC.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 05/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LicitacaoVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    @IBOutlet weak var licitacoesTV: UITableView!
    
    var licitacao = [Licitacoes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        licitacoesTV.delegate = self
        licitacoesTV.dataSource = self
        
        DataService.ds.REF_LICITACOES.observe(.value, with: { (snapshot) in
            self.licitacao.removeAll()
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                print(snapshot)
                for snap in snapshot {
                    print("DOKI: \(snap)")
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let licitacao = Licitacoes(postKey: key, postData: postDict)
                        self.licitacao.append(licitacao)
                    }
                }
            }
            self.licitacoesTV.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return licitacao.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let licita = licitacao[indexPath.row]
        if let cell = licitacoesTV.dequeueReusableCell(withIdentifier: "LicitacaoCell") as? LicitacaoCell {
            cell.configureCell(licitacoes: licita)
            return cell
        } else {
            return LicitacaoCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "PostVC") as! PostsVC
        controller.postKey = KeychainWrapper.standard.string(forKey: KEY_UID)! 
        self.present(controller, animated: true, completion: nil)
    }
}
