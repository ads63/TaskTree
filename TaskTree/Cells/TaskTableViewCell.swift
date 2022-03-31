//
//  TaskTableViewCell.swift
//  TaskTree
//
//  Created by Алексей Шинкарев on 30.03.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet var subTaskCount: UILabel!
 
    @IBAction func onTaskDescriptionIsChanged(_ sender: UITextField) {
        task?.rename(name: sender.text)
    }
    
    private var task: TaskProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configure(task: TaskProtocol) {
        self.task = task
        subTaskCount.text = String(task.children.count)
        taskDescription.text = task.name
    }
}
