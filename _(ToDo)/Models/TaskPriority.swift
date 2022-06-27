//
//  TaskType.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 26.06.22.
//

import Foundation

enum TaskPriority: String, CaseIterable {
    case high
    case medium
    case low
    
    static func getTaskPriority(from string: String) -> TaskPriority {
        for priority in TaskPriority.allCases {
            if priority.rawValue == string {
                return priority
            }
        }
        return .medium
    }
}
