//
//  ToDoWidget.swift
//  ToDoWidget
//
//  Created by Safak Yaral on 27.01.2025.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ToDoEntry {
        ToDoEntry(toDoToDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
    }

    func getSnapshot(in context: Context, completion: @escaping (ToDoEntry) -> ()) {
        let entry = ToDoEntry(toDoToDisplay: Array(SharedDatas.shared.toDos.prefix(3)))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        //get data from database
               let toDisplay =  Array(SharedDatas.shared.toDos.prefix(3))
               
               let timeline = Timeline(entries: [ToDoEntry(toDoToDisplay: toDisplay)], policy: .atEnd)
               completion(timeline)
    }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct ToDoEntry: TimelineEntry {
       var date: Date = .now
       var toDoToDisplay : [ToDoModel]
    
}

struct ToDoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("ToDo Items")
                .fontWeight(.bold)
                .padding(.bottom, 5)
    
                        
            VStack(alignment: .leading, content: {
        if entry.toDoToDisplay.isEmpty {
            Text("ToDos Completed")
                } else {
                    ForEach(entry.toDoToDisplay) {toDo in
                     HStack {
                         Button(intent: ComplateToDoWidget(id: toDo.id)) {
                             Image(systemName: toDo.isDone ? "checkmark.circle.fill" : "circle")
                             .foregroundStyle(.blue)
                         }.buttonStyle(PlainButtonStyle())
                
                                        
                    VStack(alignment:.leading) {
                        Text(toDo.name)
                            .textScale(.secondary)
                            .lineLimit(1)
                            .strikethrough(toDo.isDone,pattern:.solid,color:.primary)
                    Divider()
                            }
                                        
                        }
                                    
                    }
                                
                }
            })
                    
        }
    }
}

struct ToDoWidget: Widget {
    let kind: String = "ToDoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                ToDoWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ToDoWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("ToDo Widget")
        .description("ToDo widgets with Interactions.")
    }
}

#Preview(as: .systemSmall) {
    ToDoWidget()
} timeline: {
    ToDoEntry( toDoToDisplay:  Array(SharedDatas.shared.toDos.prefix(3)))
       ToDoEntry( toDoToDisplay:  Array(SharedDatas.shared.toDos.reversed().prefix(3)))
}
