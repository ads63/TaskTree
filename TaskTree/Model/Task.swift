//
//  Task.swift
//  TaskTree
//
//  Created by Алексей Шинкарев on 29.03.2022.
//

import Foundation

final class Task: TaskProtocol {
    internal var parent: TaskProtocol?
    internal var name: String?
    internal var children: [TaskProtocol] = []
    let isComposite = true

    init(parent: TaskProtocol? = nil, name: String = "") {
        self.parent = parent
        self.name = name
        self.children = []
    }

    func rename(name: String?) {
        self.name = name
    }

    func addSubTask(task: TaskProtocol?) -> [TaskProtocol] {
        guard var task = task else { return children }
        task.parent = self
        children.append(task)
        return children
    }

    func removeSubTask(at: Int) -> [TaskProtocol] {
        if children.indices.contains(at) {
            children.remove(at: at)
        }
        return children
    }
}
