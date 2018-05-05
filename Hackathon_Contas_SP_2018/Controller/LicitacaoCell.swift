//
//  LicitacaoCell.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 05/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase

class LicitacaoCell: UITableViewCell {

    @IBOutlet weak var nroLbl: UILabel!
    @IBOutlet weak var dtPublicacaoLbl: UILabel!
    @IBOutlet weak var dtPropostaLbl: UILabel!
    @IBOutlet weak var materialLbl: UILabel!
    @IBOutlet weak var orgaoLbl: UILabel!
    @IBOutlet weak var valorEstimadoLbl: UILabel!
    @IBOutlet weak var vizualizacoesLbl: UILabel!
    @IBOutlet weak var linkesLbl: UILabel!
    
    var licitacao: Licitacoes!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(licitacoes: Licitacoes) {
        self.licitacao = licitacoes
        nroLbl.text = licitacoes.nro
//        dtPublicacaoLbl.text = licitacoes.dataPublicacao
//        dtPropostaLbl.text = licitacoes.dataProposta
        materialLbl.text = licitacoes.material
        orgaoLbl.text = licitacoes.orgao
        valorEstimadoLbl.text = String(licitacoes.valorEstimado)
        vizualizacoesLbl.text = String(licitacoes.views)
        linkesLbl.text = String(licitacoes.star)
    }
    
}
