//
//  AddViewController.swift
//  toDoList2
//
//  Created by Darkhan Zhapparov on 15.11.2020.
//

import UIKit
import RealmSwift
import ContactsUI
class AddViewController: ColorViewController, Change, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var color:UIColor!
    func changeColor(color: UIColor) {
        self.view.backgroundColor = color
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeColor"{
            let colorPg: ColorPage = segue.destination as! ColorPage
            colorPg.changeColor = self
        }
    }
    var realm: Realm!
    let contactsController = CNContactPickerViewController()
    var toDoList: Results<ToDoListItem>{
        get{
            return realm.objects(ToDoListItem.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        contactsController.delegate = self
    }
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var toDoLabel: UITextField!
    @IBAction func addButton(_ sender: UIButton) {
        let labelInfo = toDoLabel.text!
        let newToDoListItem = ToDoListItem()
        newToDoListItem.name = labelInfo
        newToDoListItem.done = false
        
        try! self.realm.write({
            self.realm.add(newToDoListItem)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        })
    }
    //ADD IMAGE
    @IBAction func addImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Sources", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                let alertController = UIAlertController(title: "Notification", message:
                        "КАМЕРА ТУТ НЕ РАБОТАЕТ, ЭТО ВИРТУАЛКА", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Close", style: .default))

                    self.present(alertController, animated: true, completion: nil)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "PhotoLibrary", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        showImage.image = image
        
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    //ADD CONTACT
    
    @IBAction func addContact(_ sender: Any) {
        self.present(contactsController, animated: true, completion: nil)
    }
    
}
extension AddViewController : CNContactPickerDelegate{
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        self.toDoLabel.text = "Call to " + contact.phoneNumbers[0].value.stringValue
    }
}

/*
 import UIKit
 import RealmSwift

 class AddViewController: UIViewController {
     var realm: Realm!
     
     var toDoList: Results<ToDoListItem>{
         get{
             return realm.objects(ToDoListItem.self)
         }
     }
     override func viewDidLoad() {
         super.viewDidLoad()
         realm = try! Realm()
         
     }
     @IBOutlet weak var toDoLabel: UITextField!
     @IBAction func addButton(_ sender: UIButton) {
         let labelInfo = toDoLabel.text!
         let newToDoListItem = ToDoListItem()
         newToDoListItem.name = labelInfo
         newToDoListItem.done = false
         try! self.realm.write({
             self.realm.add(newToDoListItem)
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
         })
     }
 }
 */
