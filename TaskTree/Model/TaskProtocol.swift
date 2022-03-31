//
//  TaskProtocol.swift
//  TaskTree
//
//  Created by Алексей Шинкарев on 29.03.2022.
//

import Foundation
protocol TaskProtocol {
    var parent: TaskProtocol? {get set}
    var name: String? {get}
    var children: [TaskProtocol] {get}
    var isComposite: Bool {get}
    func addSubTask(task: TaskProtocol?) -> [TaskProtocol]
    func removeSubTask(at: Int) -> [TaskProtocol]
    func rename(name: String?)
}
