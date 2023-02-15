//
//  TableViewController.swift
//  ChatApp
//
//  Created by Arif Demirkoparan on 3.02.2023.
//

import UIKit
import Firebase

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messegeTextfiled: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var messages:[Message] = []
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.name
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIDE)
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(K.F.messages).order(by: K.F.date).addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let err = error {
                print("Error getting documents: \(err)")
            }else {
                if let messegesquerySnapshot = querySnapshot?.documents {
                    for doc in messegesquerySnapshot {
                        let data = doc.data()
                        if let message = data[K.F.message] as? String , let email = data[K.F.email] as? String {
                            let newMessage = Message(sender: message, nickName: email)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendMessageButton(_ sender: UIButton) {
        if let message = messegeTextfiled.text , let email  = Auth.auth().currentUser?.email {
            // Add a new document with a generated ID
            var ref: DocumentReference? = nil
            ref = db.collection(K.F.messages).addDocument(data: [
                K.F.email: email,
                K.F.message: message,
                K.F.date:Date().timeIntervalSince1970]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(ref!.documentID)")
                        DispatchQueue.main.async {
                            self.messegeTextfiled.text = ""
                        }
                    }
                }
        }
    }
    
    @IBAction func signButton(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension TableViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIDE) as! MessegaCell
        cell.messageLabel.text = message.sender
        
        if message.nickName == Auth.auth().currentUser?.email {
            cell.avatarIMG.isHidden = false
            cell.youAvatarIMG.isHidden = true
            cell.bubbleView.backgroundColor = UIColor(named: K.Color.meColor)
            
        }else {
            cell.avatarIMG.isHidden = true
            cell.youAvatarIMG.isHidden = false
            cell.bubbleView.backgroundColor = UIColor(named: K.Color.youColor)
        }
        
        return cell
    }
}
