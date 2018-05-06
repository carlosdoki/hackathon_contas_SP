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
    @IBOutlet weak var carregandoV: UIView!
    @IBOutlet weak var indicadorIV: UIActivityIndicatorView!
    @IBOutlet weak var segentC: UISegmentedControl!
    
    var licitacao = [Licitacoes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        licitacoesTV.delegate = self
        licitacoesTV.dataSource = self
        
        DataService.ds.REF_LICITACOES.observe(.value, with: { (snapshot) in
//        DataService.ds.REF_LICITACOES.queryOrdered(byChild: "fornecedores").queryEqual(toValue: KeychainWrapper.standard.string(forKey: KEY_UID)!).observe(.value, with: { (snapshot) in
            self.licitacao.removeAll()
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {

                for snap in snapshot {

                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key

                        let licitacao = Licitacoes(postKey: key, postData: postDict)
                        self.licitacao.append(licitacao)
                    }
                }
            }
            self.licitacoesTV.reloadData()
            self.carregandoV.isHidden = true
            self.indicadorIV.stopAnimating()
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
        licitacao[indexPath.row].adjustLikes()
        let controller = storyboard?.instantiateViewController(withIdentifier: "LicitacaoDetalheVC") as! LicitacaoDetalheVC
        controller.postKey = licitacao[indexPath.row].postKey
        controller.nroLiticacao = licitacao[indexPath.row].nro
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func segmentedPressed(_ sender: UISegmentedControl) {
        if segentC.selectedSegmentIndex == 0 {
            licitacao.sort(by: {$0.dataEncerramento < $1.dataEncerramento})
        }
        if segentC.selectedSegmentIndex == 1 {
            licitacao.sort(by: {$0.views > $1.views})
        }
        if segentC.selectedSegmentIndex == 2 {
            licitacao.sort(by: {$0.star > $1.star})
        }

        licitacoesTV.reloadData()
    }
}
