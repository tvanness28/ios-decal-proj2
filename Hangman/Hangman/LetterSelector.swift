//
//  LetterSelector.swift
//  Hangman
//
//  Created by Timothy Van Ness on 11/9/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class LetterSelector: UICollectionViewCell {
    
    var textLabel: UILabel!
    var chosen: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel = UILabel()
        textLabel.font = UIFont.boldSystemFont(ofSize: 18)
        textLabel.textColor = UIColor.black
        textLabel.textAlignment = .center
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        
        textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

}
