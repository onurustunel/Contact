//
//  ShowContactVC.swift
//  Contact
//
//  Created by onur on 21.11.2020.
//  Copyright © 2020 onurustunel. All rights reserved.
//

import UIKit

class ShowContactVC: UIViewController {
    
    var contact:Contact?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var centeredNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = contact?.name!
        surnameLabel.text = contact?.surname!
        numberLabel.text = contact?.number!
         
        centeredNameLabel.text = "\(nameLabel.text!) \(surnameLabel.text!) "
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toContactList", sender: nil)
    }
    
  

}
