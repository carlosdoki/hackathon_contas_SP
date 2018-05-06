//
//  LicitacaoCell.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 05/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LicitacaoCell: UITableViewCell {

    @IBOutlet weak var nroLbl: UILabel!
    @IBOutlet weak var dtPublicacaoLbl: UILabel!
    @IBOutlet weak var dtPropostaLbl: UILabel!
    @IBOutlet weak var materialLbl: UILabel!
    @IBOutlet weak var orgaoLbl: UILabel!
    @IBOutlet weak var valorEstimadoLbl: UILabel!
    @IBOutlet weak var vizualizacoesLbl: UILabel!
    @IBOutlet weak var linkesLbl: UILabel!
    @IBOutlet weak var likesImg: UIImageView!
    
    var licitacao: Licitacoes!
    var likesref : DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    @IBAction func favTapped(_ sender: Any) {
//        if likesImg.image == UIImage(named: "star_blank") {
//            likesref.child("view").setValue(1)
//            likesImg.image = UIImage(named: "star")
//        } else {
//            likesref.child("view").setValue(0)
//            likesImg.image = UIImage(named: "star_blank")
//        }
//    }
    
    func configureCell(licitacoes: Licitacoes) {
        self.licitacao = licitacoes

        DataService.ds.REF_MATERIAIS.queryOrdered(byChild: "CODIGO_ITEM").queryEqual(toValue: Int(licitacoes.material)).observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    self.valorEstimadoLbl.text = "0"
                    if let value = snap.value as?  [String : Any] {
                        if let valor = value["VALOR_UNITARIO_NEGOCIADO"] as? Double {
                            self.valorEstimadoLbl.text = "R$ \(String(format: "%.2f", valor))"
                        }
                    }
                }
            }
            self.nroLbl.text = "OC: \(licitacoes.nro)"
            self.dtPublicacaoLbl.text = licitacoes.situacao
            self.dtPropostaLbl.text = licitacoes.dataEncerramento
            self.materialLbl.text = String(licitacoes.material)
            self.orgaoLbl.text = licitacoes.orgao
            self.vizualizacoesLbl.text = String(licitacoes.views)
            self.linkesLbl.text = String(licitacoes.star)
        })
        
        self.licitacao.postKey
        likesref = DataService.ds.REF_LICITACOES.child(licitacao.postKey).child("fornecedores").child(KeychainWrapper.standard.string(forKey: KEY_UID)!)
        likesref.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.value as? Int == 0 {
                        self.likesImg.image = UIImage(named: "star_blank")
                    } else {
                      self.likesImg.image = UIImage(named: "star")
                    }
//                    print(snap.value)
                }
            }
//            if let _ = snapshot.value as? NSNull {
//                self.likesImg.image = UIImage(named: "star_blank")
//            } else {
//                self.likesImg.image = UIImage(named: "star")
//            }
        })
        
        
    }
    
}
