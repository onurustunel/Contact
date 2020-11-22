//
//  EditContactVC.swift
//  Contact
//
//  Created by onur on 21.11.2020.
//  Copyright © 2020 onurustunel. All rights reserved.
//

import UIKit

class EditContactVC: UIViewController {
    var contact:Contact?
    @IBOutlet weak var doneClicked: NSLayoutConstraint!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var surnameText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    let context = appDelegate.persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        nameText.text = contact?.name!
        surnameText.text = contact?.surname!
        numberText.text = contact?.number!
     
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        
        updateContact()
        performSegue(withIdentifier: "toShowContactVC", sender: nil)
        
        
    }
    
    // Edit and Update the data from your database
    
    func updateContact() {
        
        
        if let c = contact,
            let name = nameText.text,
            let surname = surnameText.text,
            let number = numberText.text
        
        {
            c.name = name
            c.surname = surname
            c.number = number
           
            appDelegate.saveContext()
                 
        }
        
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
      performSegue(withIdentifier: "toShowContactVC", sender: nil)
    }
    
    

}
