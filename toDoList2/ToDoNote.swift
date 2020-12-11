//
//  ToDoNote.swift
//  toDoList2
//
//  Created by Darkhan Zhapparov on 15.11.2020.
//

import Foundation
import RealmSwift

class ToDoListItem: Object {
    @objc dynamic var name = ""
    @objc dynamic var done = false
}

