//
//  ViewController.swift
//  toDoList2
//
//  Created by Darkhan Zhapparov on 15.11.2020.
//

import UIKit
import RealmSwift
class MainViewController: UITableViewController{

    var realm: Realm!
    var toDoList: Results<ToDoListItem>{
        get{
            return realm.objects(ToDoListItem.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:#selector(loadList),name:NSNotification.Name(rawValue:"load"), object: nil)
        realm = try! Realm()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = toDoList[indexPath.row]
        cell.textLabel!.text = item.name
        cell.accessoryType = item.done == true ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = toDoList[indexPath.row]
        try! self.realm.write({
            item.done = !item.done
        })
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let item = toDoList[indexPath.row]
            
            try! self.realm.write ({
                self.realm.delete(item)
            })
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func loadList(notification: NSNotification){
               self.tableView.reloadData()
           }
    
}
/*
 import UIKit
 import RealmSwift
 class MainViewController: UITableViewController{

     var realm: Realm!
     var toDoList: Results<ToDoListItem>{
         get{
             return realm.objects(ToDoListItem.self)
         }
     }
     override func viewDidLoad() {
         super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector:#selector(loadList),name:NSNotification.Name(rawValue:"load"), object: nil)
         realm = try! Realm()
     }
     
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return toDoList.count
     }
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
         let item = toDoList[indexPath.row]
         cell.textLabel!.text = item.name
         cell.accessoryType = item.done == true ? .checkmark : .none
         return cell
     }
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let item = toDoList[indexPath.row]
         try! self.realm.write({
             item.done = !item.done
         })
         tableView.reloadRows(at: [indexPath], with: .automatic)
     }
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if (editingStyle == .delete) {
             let item = toDoList[indexPath.row]
             
             try! self.realm.write ({
                 self.realm.delete(item)
             })
             tableView.deleteRows(at: [indexPath], with: .automatic)
         }
     }
     @objc func loadList(notification: NSNotification){
                //load data here
                self.tableView.reloadData()
            }
     
 }
 */
