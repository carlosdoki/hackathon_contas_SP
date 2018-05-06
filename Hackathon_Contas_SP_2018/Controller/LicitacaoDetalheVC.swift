//
//  LicitacaoDetalheVC.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 05/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import WebKit

class LicitacaoDetalheVC: UIViewController, WKNavigationDelegate {

    var postKey: String!
    var nroLiticacao: String!
    var seconds = 60 //This variable will hold a starting value of seconds. It could be any amount above 0.
    var timer = Timer()
    var isTimerRunning = false //This will be used to make sure only one timer is created at a time.
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var carregandoV: UIView!
    @IBOutlet weak var activityIV: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carregandoV.isHidden = false
        activityIV.startAnimating()
        runTimer()
        let myBlog = "https://www2.bec.sp.gov.br/bec_pregao_UI/OC/Pregao_OC_Item.aspx?chave=&OC="+String(nroLiticacao)

        let url = URL(string: myBlog)

        let request = URLRequest(url: url!)
        webView.loadRequest(request)
        
    }

    @IBAction func voltarPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func chatPressed(_ sender: UIButton) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        controller.postKey = postKey
        controller.nroLiticacao = nroLiticacao
        self.present(controller, animated: true, completion: nil)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        print("Finish Loading")
        carregandoV.isHidden = true
        activityIV.stopAnimating()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self,   selector: (#selector(LicitacaoDetalheVC.updateTimer)), userInfo: nil, repeats: true)
    }

    @objc func updateTimer() {
        carregandoV.isHidden = true
        activityIV.stopAnimating()
    }

}
