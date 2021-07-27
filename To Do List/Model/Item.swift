//
//  Item.swift
//  To Do List
//
//  Created by Nate Howell on 7/19/21.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date(timeIntervalSinceReferenceDate: 118800)
}
