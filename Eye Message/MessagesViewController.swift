//
//  ViewController.swift
//  Eye Message
//
//  Created by Muhammad Abdullah on 03/09/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit
import SwiftSoup
struct ChatMessgaes {
    var isIncoming:Bool?
    var messgae:String?
}

class MessagesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    lazy var tableView:UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor(white: 0.95, alpha: 1)
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
        tf.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
        tf.tintColor = UIColor.blue
        tf.contentVerticalAlignment = .center
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
    
    private func fetchFirstQuestionURL(_ query: String)->String{
        var QuestionLink = ""
        
        let myURLString = "https://stackoverflow.com/search?q=\(query)"
        guard let myURL = URL(string: myURLString) else {
            print("Error: \(myURLString) doesn't seem to be a valid URL")
            return "Error: \(myURLString) doesn't seem to be a valid URL"
        }
        
        do {
            let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
            //print("HTML : \(myHTMLString)")
            let doc:Document = try SwiftSoup.parse(myHTMLString)
            //post-layout
            let link: Element? = doc.body()
            let cl = try link?.getElementsByClass("summary").first()
            let answerLink: Element? = try cl?.getElementsByClass("result-link").first()
            let getLink:Element? = try answerLink?.getElementsByTag("h3").first()
            let linkz: Element = try getLink!.select("a").first()!
            let linkHref: String = try linkz.attr("href"); // "http://example.com/"
            
            
            
            messages.append(ChatMessgaes(isIncoming: false, messgae: linkHref))
            indexForCell += 1
            QuestionLink = "https://stackoverflow.com"+linkHref
            
            
                guard let myURL2 = URL(string: QuestionLink) else {
                print("Error: \(QuestionLink) doesn't seem to be a valid URL")
                return ("Error: \(QuestionLink) doesn't seem to be a valid URL")
            }
            
            do {
                let myHTMLString2 = try String(contentsOf: myURL2, encoding: .ascii)
                //print("HTML : \(myHTMLString2)")
                let doc2:Document = try SwiftSoup.parse(myHTMLString2)
                //post-layout
                let link2: Element? = doc2.body()
                
                
                let getAnswer = try link2?.getElementsByClass("answer accepted-answer").first()
                
                
                let cleanAnswer = try getAnswer?.getElementsByClass("post-text")
                print(cleanAnswer?.array())
                
                messages.append(ChatMessgaes(isIncoming: false, messgae: try cleanAnswer?.text()))
                indexForCell += 1
                
            } catch let error2 {
                print("Error: \(error2)")
            }
            
            
            
           // let text = try cl?.text()
            //print(link?.firstElementSibling())
        } catch let error {
            print("Error: \(error)")
        }
        
        return QuestionLink
    }
    
    @objc func sendButtonPressed(_ sender:UIButton){
        if (inputMessageTextFiled.text?.isEmpty)! {
            
        }
        else{
            messages.append(ChatMessgaes(isIncoming: true, messgae: inputMessageTextFiled.text))
            indexForCell += 1
            tableView.scrollToRow(at: IndexPath(row: indexForCell, section: 0), at: .bottom, animated: true)
            scrollToBottom()
            
            fetchFirstQuestionURL(inputMessageTextFiled.text!.replacingOccurrences(of: " ", with: "+"))
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

