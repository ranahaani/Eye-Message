//
//  MessagesTableViewCell.swift
//  Eye Message
//
//  Created by Muhammad Abdullah on 03/09/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit
class MessagesTableViewCell: UITableViewCell {

    
    let messageLabel = UILabel()
    let bubbleBackgroundView = UIView()
    
    var trainlingConstraint:NSLayoutConstraint!
    var leadingConstraint:NSLayoutConstraint!
    var isIncoming:Bool!{
        didSet{
            bubbleBackgroundView.backgroundColor = isIncoming ? .white : .darkGray
            messageLabel.textColor = isIncoming ? .black : .white
            
            
            if isIncoming{
                trainlingConstraint.isActive = true
                leadingConstraint.isActive = false
            }
            else{
                trainlingConstraint.isActive = false
                leadingConstraint.isActive = true
            }

        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        bubbleBackgroundView.backgroundColor = .gray
       // label.text = "Haaani is great man, he want to learn swift, he is not a godd boy but he i s xs ushdcoas"
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        selectionStyle = .none
        bubbleBackgroundView.layer.cornerRadius = 12

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        let constrant = [messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
                           
                           messageLabel.topAnchor.constraint(equalTo: topAnchor,constant: 32),
                           messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -32),
                           
                           
                           bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
                           bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
                           bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
                           bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16)
                           ]
        
        NSLayoutConstraint.activate(constrant)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 32)
        trainlingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -32)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
