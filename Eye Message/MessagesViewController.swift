//
//  ViewController.swift
//  Eye Message
//
//  Created by Muhammad Abdullah on 03/09/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit

struct ChatMessgaes {
    var isIncoming:Bool?
    var messgae:String?
}

class MessagesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.scrollsToTop = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var inputMessageTextFiled:UITextField = {
       let tf = UITextField()
        tf.placeholder = "Text Message"
        tf.layer.cornerRadius = 12
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.borderWidth = 2
        tf.tintColor = UIColor.blue
        tf.contentVerticalAlignment = .center
        //tf.textAlignment = .left
        tf.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tf.layer.masksToBounds = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var sendButton:UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "send"), for: .normal)
        btn.addTarget(self, action: #selector(sendButtonPressed(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    var indexForCell:Int!{
        didSet{
          // indexForCell = messages.count
            //tableView.beginUpdates()
           
            let indexPath = IndexPath(row: indexForCell, section: 0)
            tableView.insertRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            //scrollToBottom()
            //tableView.scrollsToTop = false
            //tableView.endUpdates()
            
        }
    }
    var messages = [ChatMessgaes(isIncoming: true, messgae: "This is my first message"),
                   ChatMessgaes(isIncoming: true, messgae: "This is my second message"),
                   ChatMessgaes(isIncoming: false, messgae: "This is otherside first message"),
                   ChatMessgaes(isIncoming: false, messgae: "And this my another messsage, I don't why he send this message"),
                   ChatMessgaes(isIncoming: true, messgae: "And this my another messsage, I don't why he send this message First message And this is my second messages, send by Anam And this my another messsage, I don't why he send this message")
        
                   ]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Eye Message"
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        indexForCell = messages.count - 1
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MessagesTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        view.addSubview(inputMessageTextFiled)
        view.addSubview(sendButton)
        setupViews()
        
    }
    
    @objc func sendButtonPressed(_ sender:UIButton){
        if (inputMessageTextFiled.text?.isEmpty)! {
            
        }
        else{
            messages.append(ChatMessgaes(isIncoming: true, messgae: inputMessageTextFiled.text))
            indexForCell += 1
            tableView.scrollToRow(at: IndexPath(row: indexForCell, section: 0), at: .bottom, animated: true)
            
            inputMessageTextFiled.text = ""
        }
    }
    
    private func setupViews(){
        let constraint = [tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                         tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                         tableView.topAnchor.constraint(equalTo: view.topAnchor),
                         tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10),
                         
                         
                         inputMessageTextFiled.leadingAnchor.constraint(equalTo: tableView.leadingAnchor,constant: 10),
                         inputMessageTextFiled.widthAnchor.constraint(equalTo: tableView.widthAnchor,constant: -20),
                         inputMessageTextFiled.heightAnchor.constraint(equalToConstant: 50),
                         
                         inputMessageTextFiled.bottomAnchor.constraint(equalTo: tableView.bottomAnchor,constant: 0),
                         
                         sendButton.widthAnchor.constraint(equalToConstant:40),
                         sendButton.heightAnchor.constraint(equalToConstant: 40),
                         sendButton.trailingAnchor.constraint(equalTo: inputMessageTextFiled.trailingAnchor, constant: -10),
                         sendButton.centerYAnchor.constraint(equalTo: inputMessageTextFiled.centerYAnchor)
        
        ]
        
        NSLayoutConstraint.activate(constraint)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessagesTableViewCell
        
        if messages[indexPath.row].isIncoming! {
            cell.isIncoming = true
        }
        else {
            cell.isIncoming = false
        }
        cell.messageLabel.text = messages[indexPath.row].messgae
        return cell
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToBottom()
    }
    func scrollToBottom() {
        var yOffset: CGFloat = 0
        
        if tableView.contentSize.height > tableView.bounds.size.height {
            yOffset = tableView.contentSize.height - tableView.bounds.size.height
        }
        
        tableView.setContentOffset(CGPoint(x: 0, y: yOffset + 40), animated: false)
    }


}

