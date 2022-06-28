//
//  CreateTaskView.swift
//  _(ToDo)
//
//  Created by Artem Kutasevich on 26.06.22.
//

import SwiftUI

struct CreateTaskView: View {
    @EnvironmentObject var viewModel: TasksViewModel
    @Environment(\.self) var enviroment
    @Namespace var animation
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Text(viewModel.editTask == nil ? "Create Task" : "Edit Task")
                .titleStyle()
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    SymbolButton(
                        symbolName: "arrow.left",
                        symbolColor: BackgroundColors.blackColor,
                        function: {
                            viewModel.editTask = nil
                            enviroment.dismiss()
                        })
                }
                .overlay(alignment: .trailing) {
                    if let editTask = viewModel.editTask {
                        SymbolButton(
                            symbolName: "trash",
                            symbolColor: .red,
                            function: {
                                enviroment.managedObjectContext.delete(editTask)
                                try? enviroment.managedObjectContext.save()
                                enviroment.dismiss()
                                viewModel.editTask = nil
                            })
                    }
                }
            
            // MARK: Task Color
            
            Group {
                VStack(alignment: .leading) {
                    Text("Task Color")
                        .captionStyle()
                    
                    HStack(spacing: 16) {
                        ForEach(CardColors.allCases, id: \.self) { color in
                            Circle()
                                .fill(Color(color.rawValue))
                                .frame(width: 25, height: 25)
                                .background {
                                    if viewModel.taskColor == color {
                                        Circle()
                                            .stroke(.gray)
                                            .padding(-3)
                                    }
                                }
                                .contentShape(Circle())
                                .onTapGesture {
                                    viewModel.taskColor = color
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Divider()
            }
            
            // MARK: Task Deadline
            
            Group {
                VStack(alignment: .leading) {
                    Text("Task Deadline")
                        .captionStyle()
                        .padding(.bottom, 6)
                    
                    Text(viewModel.taskDeadline.formatted(date: .abbreviated, time: .omitted) + ", " + viewModel.taskDeadline.formatted(date: .omitted, time: .shortened))
                        .calloutStyle()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .overlay(alignment: .bottomTrailing) {
                    SymbolButton(
                        symbolName: "calendar",
                        symbolColor: BackgroundColors.blackColor,
                        function: {
                            viewModel.showingDatePicker.toggle()
                        })
                }
                .padding()
                
                Divider()
            }
            
            // MARK: Task Title
            
            Group {
                VStack(alignment: .leading) {
                    Text("Task Title")
                        .captionStyle()
                        .padding(.bottom, 6)
                    
                    TextField("", text: $viewModel.taskTitle)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Divider()
            }
            
            // MARK: Task Type
            
            Group {
                VStack(alignment: .leading) {
                    Text("Task Priority")
                        .captionStyle()
                        .padding(.bottom, 6)
                    
                    HStack {
                        ForEach(TaskPriority.allCases, id: \.self) { type in
                            Text(type.rawValue)
                                .calloutStyle(color: viewModel.taskType == type ? .white : BackgroundColors.blackColor)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                                .background {
                                    if viewModel.taskType == type {
                                        Capsule()
                                            .fill(BackgroundColors.blackColor)
                                            .matchedGeometryEffect(id: "TYPE", in: animation)
                                    } else {
                                        Capsule()
                                            .stroke()
                                    }
                                }
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.taskType = type
                                    }
                                }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                // MARK: Save Button
                
                Button(action: {
                    if viewModel.addTask(context: enviroment.managedObjectContext) {
                        enviroment.dismiss()
                    }
                }, label: {
                    Text("Save Task")
                        .calloutStyle(color: .white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background {
                            Capsule()
                                .fill(.black)
                        }
                })
                .frame(maxHeight: .infinity, alignment: .bottom)
                .disabled(viewModel.taskTitle == "")
                .opacity(viewModel.taskTitle == "" ? 0.6 : 1)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .overlay {
            ZStack {
                if viewModel.showingDatePicker {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .ignoresSafeArea()
                        .onTapGesture {
                            viewModel.showingDatePicker = false
                        }
                    
                    DatePicker("", selection: $viewModel.taskDeadline, in: Date.now...Date.distantFuture)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
            }
            .animation(.easeInOut, value: viewModel.showingDatePicker)
        }
    }
}

struct CreateTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTaskView()
            .environmentObject(TasksViewModel())
    }
}
