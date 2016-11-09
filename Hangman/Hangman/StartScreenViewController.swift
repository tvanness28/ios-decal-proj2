//
//  StartScreenViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class StartScreenViewController: UIViewController {
    
    var titleLabel = UILabel()
    var startGameButton = UIButton(type: UIButtonType.system)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        
        titleLabel.text = "Hang Man"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 42.0)
        titleLabel.textColor = UIColor.black
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant:50).isActive = true
        
        
        startGameButton.setTitle("Start", for: UIControlState.normal)
        startGameButton.addTarget(self, action: #selector(startPressed), for: .touchUpInside)
        self.view.addSubview(startGameButton)
        startGameButton.translatesAutoresizingMaskIntoConstraints = false
        
        startGameButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 50).isActive = true
        startGameButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startPressed(_ sender: UIButton!) {
        let gameViewCtrl:GameViewController = GameViewController()
        self.present(gameViewCtrl, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
