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
                HStack {
                    VStack(alignment: .leading) {
                        Text("Welcome back")
                            .calloutStyle()
                        Text("Today's plan")
                            .titleStyle()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.openSettings.toggle()
                    }, label: {
                        Image(systemName: "gearshape.fill")
                            .symbolStyle()
                    })
                }
                
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
                        .calloutStyle(color: .white)
                } icon: {
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding()
                .background(BackgroundColors.blackColor, in: Capsule())
            })
        }
        .fullScreenCover(isPresented: $viewModel.openEditTask) {
            viewModel.resetTaskData()
        } content: {
            CreateTaskView()
                .environmentObject(viewModel)
        }
        .fullScreenCover(isPresented: $viewModel.openSettings) {
            SettingsView()
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
    }
    
    // MARK: - TaskRowView
    
    @ViewBuilder
    func TaskRowView(task: Task) -> some View {
        VStack(alignment: .leading) {
            HStack {
                HStack {
                    Text(task.priority ?? "")
                        .calloutStyle()
                        .padding(.horizontal)
                    
                    Text(task.title ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                }
                .padding(.bottom, 6)
                
                Spacer()
                
                Button(action: {
                    viewModel.editTask = task
                    viewModel.openEditTask = true
                    viewModel.setupTask()
                }, label: {
                    Image(systemName: "square.and.pencil")
                        .foregroundColor(BackgroundColors.blackColor)
                })
            }
            .padding(.bottom)
            
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
                
                Button(action: {
                    task.isDone.toggle()
                    try? enviroment.managedObjectContext.save()
                }, label: {
                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                        .symbolStyle(color: task.isDone ? Color(CardColors.green.rawValue) : .black)
                })
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
