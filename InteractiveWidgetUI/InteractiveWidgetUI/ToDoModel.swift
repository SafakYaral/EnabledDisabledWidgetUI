//
//  ToDoModel.swift
//  InteractiveWidgetUI
//
//  Created by Safak Yaral on 27.01.2025.
//

import Foundation

struct ToDoModel : Identifiable {
    let id : String = UUID().uuidString
    var name: String
    var isDone : Bool = false
}


class SharedDatas {
    static let shared = SharedDatas()

    var toDos : [ToDoModel] = [
        .init(name: "Test1"),
        .init(name: "Test2"),
        .init(name: "Test3")
    ]
}
