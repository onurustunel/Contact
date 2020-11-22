//
//  NewContactVC.swift
//  Contact
//
//  Created by onur on 21.11.2020.
//  Copyright © 2020 onurustunel. All rights reserved.
//

import UIKit

class NewContactVC: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var surnameLabel: UITextField!
    @IBOutlet weak var numberLabel: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    let context = appDelegate.persistentContainer.viewContext
    
    override func viewWillAppear(_ animated: Bool) {
   
        self.hideKeyboardWhenTappedAround()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.attributedPlaceholder = NSAttributedString(string: "Name:",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
       surnameLabel.attributedPlaceholder = NSAttributedString(string: "Surname:",
       attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        numberLabel.attributedPlaceholder = NSAttributedString(string: "Phone Number:",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        performSegue(withIdentifier: "toContactVC", sender: nil)
        
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        
        
        if nameLabel.text == "" || surnameLabel.text == "" || numberLabel.text == "" {
            let alert = UIAlertController(title: "Warning!", message: "Please fill the blank areas!", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert,animated: true , completion: nil)
            
        } else {
            
           saveContact()
           
        }
      
        
    }
    
    // code for saving the new contact to Database
    
    func saveContact() {
        
        if let name = nameLabel.text,
             let surname = surnameLabel.text,
             let number = numberLabel.text {
                  
             let contact = Contact(context: context)
             contact.name = name
             contact.surname = surname
             contact.number = number
           
             appDelegate.saveContext()
              
        }
             performSegue(withIdentifier: "toContactVC", sender: nil)
         
         
    }
    

}
