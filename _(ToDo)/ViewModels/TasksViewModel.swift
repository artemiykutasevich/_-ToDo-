//
//  TasksViewModel.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 26.06.22.
//

import SwiftUI
import CoreData

class TasksViewModel: ObservableObject {
    @Published var openEditTask: Bool = false
    @Published var showingDatePicker: Bool = false
    @Published var editTask: Task?
    
    @Published var taskTitle: String = ""
    @Published var taskColor: CardColors = .blue
    @Published var taskDeadline: Date = Date()
    @Published var taskType: TaskPriority = .medium
    
    @Published var openSettings: Bool = false
    
    func addTask(context: NSManagedObjectContext) -> Bool {
        var task: Task!
        
        if let editTask = editTask {
            task = editTask
        } else {
            task = Task(context: context)
        }
        
        task.title = taskTitle
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
        taskColor = .blue
        taskType = .medium
        taskDeadline = Date()
    }
    
    func setupTask() {
        if let editTask = editTask {
            taskTitle = editTask.title ?? ""
            taskColor = CardColors.getCardColor(from: editTask.color ?? "")
            taskType = TaskPriority.getTaskPriority(from: editTask.priority ?? "")
            taskDeadline = editTask.deadline ?? Date()
        }
    }
}
