//
//  LetterSelector.swift
//  Hangman
//
//  Created by Timothy Van Ness on 11/9/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class LetterSelector: UICollectionViewCell {
    
    var keyImgView = UIImageView(image: #imageLiteral(resourceName: "Letter-Box.png"))
    var textLabel = UILabel()
    var chosen: Bool = false
    var square = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        contentView.addSubview(square)
//        square.translatesAutoresizingMaskIntoConstraints = false
//
//        square.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
//        square.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
//        
        contentView.addSubview(keyImgView)
        keyImgView.translatesAutoresizingMaskIntoConstraints = false
        
        keyImgView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        keyImgView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        textLabel.font = UIFont.boldSystemFont(ofSize: 18)
        textLabel.textColor = UIColor.black
        textLabel.textAlignment = .center
        
        contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }

}
