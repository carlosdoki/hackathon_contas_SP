//
//  CadastroVC.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 06/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase
import Alamofire
import SwiftKeychainWrapper

class CadastroVC: UIViewController,UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var nomeTxt: UITextField!
    @IBOutlet weak var cnpjTxt: UITextField!
    @IBOutlet weak var materialTbl: UITableView!
    @IBOutlet weak var carregandoV: UIView!
    @IBOutlet weak var activityIV: UIActivityIndicatorView!
    @IBOutlet weak var materialTxt: UITextField!
    @IBOutlet weak var excluirBtn: RoundedButton!
    
    var resultKeys = [Int]()
    var resultValues = [String]()
    var material = [Material]()
    var materialPicker = UIPickerView()
    var itemOC : Int = 0
    var mat_postkey : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        cnpjTxt.setBottomLine(borderColor: cnpjTxt.textColor!)
        nomeTxt.setBottomLine(borderColor: nomeTxt.textColor!)
        
        materialPicker.delegate = self
        materialPicker.dataSource = self
                
        materialTbl.delegate = self
        materialTbl.dataSource = self
        
        excluirBtn.isEnabled = false
        
        materialTxt.inputView = materialPicker
        carregandoV.isHidden = false
        activityIV.startAnimating()
        
        DataService.ds.REF_FORNECEDORES.child(KeychainWrapper.standard.string(forKey: KEY_UID)!).observe(.value, with: {(snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == "nome"
                    {
                        self.nomeTxt.text = snap.value as? String
                    }
                    if snap.key == "cnpj"
                    {
                        self.cnpjTxt.text = snap.value as? String
                    }
                }
            }
            
        })
        
        Alamofire.request("https://www.bec.sp.gov.br/BEC_API/API/pregaoM/NegociacaoItemOC").responseJSON {
            response in
            
            switch response.result {
            case .success:
                if let result = response.result.value {
                    let JSON = result as! NSArray
                    for json in JSON {
                        let dados = json as! NSDictionary
                        self.resultKeys.append(dados["Codigo"] as! Int)
                        let desc = dados["DescItem"] as! String
                        self.resultValues.append(desc)
                    }
                }

                self.materialPicker.reloadAllComponents()
                DataService.ds.REF_FORNECEDORES.child(KeychainWrapper.standard.string(forKey: KEY_UID)!).child("material").observe(.value, with: {(snapshot) in
                    self.material.removeAll()
                    if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                        for snap in snapshot {
                            if let postDict = snap.value as? Dictionary<String, AnyObject> {
                                let key = snap.key
                                
                                let material = Material(postKey: key, postData: postDict)
                                self.material.append(material)
                            }
                        }
                    }
                    self.materialTbl.reloadData()
                    self.carregandoV.isHidden = true
                    self.activityIV.stopAnimating()
                })
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
        
    }
    
    @IBAction func excluirPressed(_ sender: UIButton) {
        let refreshAlert = UIAlertController(title: "Exclusão", message: "Confirma a exclusão do material \(materialTxt.text!)", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            let ref = DataService.ds.REF_FORNECEDORES.child(KeychainWrapper.standard.string(forKey: KEY_UID)!).child("material").child(self.mat_postkey)
            
            ref.removeValue { error, _ in
                
                print(error)
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func incluirPressed(_ sender: UIButton) {
        let inc_material = DataService.ds.REF_FORNECEDORES.child(KeychainWrapper.standard.string(forKey: KEY_UID)!).child("material").childByAutoId()
        
        inc_material.child("itemOC").setValue(itemOC)
        inc_material.child("descricao").setValue(materialTxt.text)
        excluirBtn.isEnabled = false
        materialTxt.text = ""
        
        Alamofire.request("https://www.bec.sp.gov.br/BEC_API/API/pregaoM/NegociacaoItemOC/\(itemOC)").responseJSON {
            response in
            
            switch response.result {
            case .success:
                if let result = response.result.value {
                    let JSON = result as! NSArray
                    for json in JSON {
                        let dados = json as! NSDictionary
                        
                        let licita = DataService.ds.REF_LICITACOES.childByAutoId()
                        licita.child("nro").setValue(dados["OC"])
                        licita.child("orgao").setValue(dados["UNIDADE_COMPRADORA"])
                        licita.child("situacao").setValue(dados["SITUACAO"])
                        licita.child("dataEncerramento").setValue("")
                        if dados["DT_ENCERRAMENTO"] as? String != nil {
                            licita.child("dataEncerramento").setValue(dados["DT_ENCERRAMENTO"])
                        }
                        licita.child("material").setValue(self.itemOC)
                        let randomNum:UInt32 = arc4random_uniform(15)
                        let randomNum2 = randomNum / 3
                        licita.child("star").setValue(randomNum2)
                        licita.child("views").setValue(0)
                        licita.child("fornecedores").child(KeychainWrapper.standard.string(forKey: KEY_UID)!).child("view").setValue(0)
                    
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        excluirBtn.isEnabled = true
        materialTxt.text = material[indexPath.row].descricao
        mat_postkey = material[indexPath.row].postKey
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return material.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let materia = material[indexPath.row]
        if let cell = materialTbl.dequeueReusableCell(withIdentifier: "MaterialCell") as? MaterialCell {
            cell.configureCell(material: materia)
            return cell
        } else {
            return MaterialCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return resultValues[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return resultValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        materialTxt.text = resultValues[row]
        itemOC = resultKeys[row]
        self.view.endEditing(true)
    }
}
