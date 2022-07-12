//
//  TasksViewModel.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 26.06.22.
//

import SwiftUI
import CoreData

class TasksViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var openEditTask: Bool = false
    @Published var showingDatePicker: Bool = false
    @Published var editTask: Task?
    
    @Published var taskTitle: String = ""
    @Published var taskDescription: String = ""
    @Published var taskColor: CardColors = .blue
    @Published var taskDeadline: Date = Date()
    @Published var taskType: TaskPriority = .medium
    
    @Published var openSettings: Bool = false
    
    // MARK: Functions
    
    func addTask(context: NSManagedObjectContext) -> Bool {
        var task: Task!
        
        if let editTask = editTask {
            task = editTask
        } else {
            task = Task(context: context)
        }
        
        task.title = taskTitle
        task.body = taskDescription
        task.color = taskColor.rawValue
        task.deadline = taskDeadline
        task.priority = taskType.rawValue
        task.isDone = false
        
        if let _ = try? context.save() {
            return true
        }
        return false
    }
    
    func resetTaskData() {
        taskTitle = ""
        taskDescription = ""
        taskColor = .blue
        taskType = .medium
        taskDeadline = Date()
    }
    
    func setupTask() {
        if let editTask = editTask {
            taskTitle = editTask.title ?? ""
            taskDescription = editTask.body ?? ""
            taskColor = CardColors.getCardColor(from: editTask.color ?? "")
            taskType = TaskPriority.getTaskPriority(from: editTask.priority ?? "")
            taskDeadline = editTask.deadline ?? Date()
        }
    }
}
