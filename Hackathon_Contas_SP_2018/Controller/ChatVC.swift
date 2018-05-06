//
//  ChatVC.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 05/05/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
//import JSQMessagesViewController
import Firebase
import SwiftKeychainWrapper


class ChatVC: JSQMessagesViewController {

    var messages = [JSQMessage]()
    var postKey: String!
    var nroLiticacao: String!
    
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }()
    
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        automaticallyScrollsToMostRecentMessage = true
        
        senderId = KeychainWrapper.standard.string(forKey: KEY_UID)!
        senderDisplayName = "..."
        addViewOnTop()
        
        self.collectionView?.collectionViewLayout.sectionInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)

        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        let query = DB_BASE.child("licitacao").child(postKey).child("post").queryLimited(toLast: 10)

        _ = query.observe(.childAdded, with: { [weak self] snapshot in

            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                !text.isEmpty
            {
                if let message = JSQMessage(senderId: id, displayName: name, text: text)
                {
                    self?.messages.append(message)

                    self?.finishReceivingMessage()
                }
            }
        })
    }

    func addViewOnTop() {
        let selectableView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 120))
        selectableView.backgroundColor = UIColor.white

        let imageView = UIImageView(image: #imageLiteral(resourceName: "LICITAE1Asset 1"))
        imageView.contentMode = .scaleAspectFit
        imageView.center = selectableView.center
        imageView.frame(forAlignmentRect: CGRect(x: 80, y: 12, width: 296, height: 97))

        selectableView.addSubview(imageView)

        let selectableView2 = UIView(frame: CGRect(x: 0, y: 120, width: self.view.bounds.width, height: 60))
//        selectableView2.backgroundColor = UIColor(displayP3Red: 53/255, green: 112/255, blue: 255/255, alpha: 1.0)
//        selectableView2.backgroundColor = UIColor.gray
        var color1 = hexStringToUIColor(hex: "#3570FF")
        selectableView2.backgroundColor = color1
        
        let randomViewLabel = UILabel(frame: CGRect(x: 70, y: 22, width: 250, height: 16))
        randomViewLabel.text = nroLiticacao

        let button = UIButton(type: .system) // let preferred over var here
        button.frame = CGRect(x: 8, y: 8, width: 50, height: 50)
        //button.backgroundColor = UIColor.white
        
        button.setImage(#imageLiteral(resourceName: "backAsset 3"), for:UIControlState.normal)
        button.addTarget(self, action: #selector(buttonAction), for: UIControlEvents.touchUpInside)


        selectableView2.addSubview(randomViewLabel)
        selectableView2.addSubview(button)

        view.addSubview(selectableView)
        view.addSubview(selectableView2)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble : incomingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = DB_BASE.child("licitacao").child(postKey).child("post").childByAutoId()
        //let ref = DataService.ds.REF_POSTS.childByAutoId()
        
        let message = ["sender_id": senderId, "name": senderDisplayName, "text": text]
        
        ref.setValue(message)
        
        finishSendingMessage()
    }

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
