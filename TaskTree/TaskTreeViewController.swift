//
//  TaskTreeViewController.swift
//  TaskTree
//
//  Created by Алексей Шинкарев on 29.03.2022.
//

import UIKit

class TaskTreeViewController: UIViewController,
    UITableViewDataSource,
    UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navigationBar: UINavigationBar!
    @IBAction func onAddButtonPressed(_ sender: UIBarButtonItem) {
        addTask()
    }

    @IBAction func onBackButtonPressed(_ sender: UIBarButtonItem) {
        goUp()
    }

    private var tasks: [TaskProtocol] = []
    private var parentTask: TaskProtocol? {
        didSet {
            self.setTitle(titleText: parentTask?.name)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        parentTask = Task(parent: nil, name: "Root tasks")
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(
                nibName: "TaskTableViewCell",
                bundle: nil),
            forCellReuseIdentifier: "taskCell")
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = 44
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTitle(titleText: parentTask?.name)
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int
    {
        tasks.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell =
            tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
                as? TaskTableViewCell else { return UITableViewCell() }
        cell.configure(task: tasks[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath)
    {
        goDown(task: tasks[indexPath.row])
    }

    /*
      Support conditional editing of the table view.
     */
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool
    {
//          Return false if you do not want the specified item to be editable.
        true
    }

    /*
      Support editing the table view.
     */
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeTask(at: indexPath.row)
        }
    }

    public func goDown(task: TaskProtocol?) {
        guard let task = task,
              task.isComposite else { return }
        tasks = task.children
        parentTask = task
        tableView.reloadData()
    }

    private func goUp() {
        guard let task = parentTask,
              let parent = task.parent
        else { return }
        parentTask = parent
        tasks = parent.children
        tableView.reloadData()
    }

    private func setTitle(titleText: String?) {
        navigationBar.items?.first?.title = titleText ?? ""
    }

    private func addTask() {
        guard let parentTask = parentTask else { return }
        tasks = parentTask.addSubTask(task: Task())
        tableView.reloadData()
    }

    private func removeTask(at: Int) {
        guard let parentTask = parentTask else { return }
        tasks = parentTask.removeSubTask(at: at)
        tableView.reloadData()
    }
}
