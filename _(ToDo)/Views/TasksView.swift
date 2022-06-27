//
//  TasksView.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 26.06.22.
//

import SwiftUI

struct TasksView: View {
    @StateObject private var viewModel = TasksViewModel()
    
    @Namespace var animation
    
    @FetchRequest(
        entity: Task.entity(),
        sortDescriptors: [NSSortDescriptor(
            keyPath: \Task.deadline,
            ascending: false)],
        predicate: nil,
        animation: .easeInOut) var tasks: FetchedResults<Task>
    
    @Environment(\.self) var enviroment
    
    // MARK: Body
    
    var body: some View {
        ScrollView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Welcome back")
                        .font(.callout)
                    Text("Today's plan")
                        .titleStyle()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                TaskView()
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            Button(action: {
                viewModel.openEditTask.toggle()
            }, label: {
                Label {
                    Text("Add task")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding()
                .background(Color(BackgroundColors.black.rawValue), in: Capsule())
            })
        }
        .fullScreenCover(isPresented: $viewModel.openEditTask) {
            viewModel.resetTaskData()
        } content: {
            CreateTaskView()
                .environmentObject(viewModel)
        }
    }
    
    // MARK: - Task View
    
    @ViewBuilder
    func TaskView() -> some View {
        LazyVStack {
            ForEach(tasks) { task in
                TaskRowView(task: task)
            }
        }
        .padding()
    }
    
    // MARK: - TaskRowView
    
    @ViewBuilder
    func TaskRowView(task: Task) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(task.priority ?? "")
                    .font(.callout)
                    .padding(8)
                    .padding(.horizontal)
                    .background {
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                
                Spacer()
                
                Button(action: {
                    viewModel.editTask = task
                    viewModel.openEditTask = true
                    viewModel.setupTask()
                }, label: {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(Color(BackgroundColors.black.rawValue))
                })
            }
            
            Text(task.title ?? "")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.vertical)
            
            HStack(alignment: .bottom, spacing: 0) {
                VStack(alignment: .leading) {
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .font(.caption)
                    
                    Label {
                        Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        Image(systemName: "clock")
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if !task.isDone {
                    Button(action: {
                        task.isDone.toggle()
                        try? enviroment.managedObjectContext.save()
                    }, label: {
                        Circle()
                            .stroke(Color(BackgroundColors.black.rawValue))
                            .frame(width: 25, height: 25)
                            .contentShape(Circle())
                    })
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(task.color ?? "Blue"))
        }
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
