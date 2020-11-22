//
//  ViewController.swift
//  Contact
//
//  Created by onur on 21.11.2020.
//  Copyright © 2020 onurustunel. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {
    
    @IBOutlet weak var contactTableView: UITableView!
    let context = appDelegate.persistentContainer.viewContext
     var contactList = [Contact]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    var searchedWord = ""
    var isSearchingNow = false
   
    
    override func viewWillAppear(_ animated: Bool) {
        getContacts()
        contactTableView.reloadData()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        self.hideKeyboardWhenTappedAround()
        
        
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // Get the all data from your database
    
    
    func getContacts() {
        
        do {
            contactList = try context.fetch(Contact.fetchRequest())
               } catch  {
                   print(error)
               }
            }
    
    
    func makeSearch(name:String){
           
           let fetchRequest:NSFetchRequest<Contact> = Contact.fetchRequest()
           
           fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", name)
           
           do {
               contactList = try context.fetch(fetchRequest)
           } catch  {
               print(error)
           }
       }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ContactTVC
        cell.contactNameLabel.text =  "\(contactList[indexPath.row].name!) \(contactList[indexPath.row].surname!)"
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
        
    }
    
    
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 50.0
       
   }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = sender as? Int
        if segue.identifier == "showContactVC" {
           let destinationVC = segue.destination as! ShowContactVC
            destinationVC.contact = contactList[index!]
            
        }
        
        if segue.identifier == "toEditVC" {
                  let destinationVC = segue.destination as! EditContactVC
                   destinationVC.contact = contactList[index!]
                   
               }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showContactVC", sender: indexPath.row)
        
    }
    
    
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // Delete the data from database
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            
             let person = self.contactList[indexPath.row]
             
             self.context.delete(person)
             
             appDelegate.saveContext()
          
             
             if self.isSearchingNow {
                 self.makeSearch(name: self.searchedWord)
             }else{
                 self.getContacts()
             }
//
             self.contactTableView.reloadData()
        }
        
        let updateAction = UIContextualAction(style: .normal, title: "Update") {  (contextualAction, view, boolValue) in

             self.performSegue(withIdentifier: "toEditVC", sender: indexPath.row)
        }

        return UISwipeActionsConfiguration(actions: [deleteAction,updateAction])
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           
           searchedWord = searchText
           
           if searchText == "" {
                isSearchingNow = false
                getContacts()
           }else{
                isSearchingNow = true
            makeSearch(name: searchedWord)
            
           }
           
           contactTableView.reloadData()
           
       }
    
    
}

// Hide the keyboard when tapped anywhere
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

