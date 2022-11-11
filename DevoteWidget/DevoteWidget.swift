//
//  DevoteWidget.swift
//  DevoteWidget
//
//  Created by Philip Al-Twal on 10/24/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    //MARK: - PLACEHOLDER
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    //MARK: - SNAPSHOT
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    //MARK: - TIMELINE
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

//MARK: - TIMELINE ENTRY
struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DevoteWidgetEntryView : View {
    //MARK: - PROPERTIES
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    //MARK: - COMPUTED PROPETIES
    var fontStyle: Font {
        if widgetFamily == .systemSmall {
            return .system(.footnote, design: .rounded)
        }else{
            return .system(.headline, design: .rounded)
        }
    }
    
    //MARK: - WIDGET VIEW BODY
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                backgroundGradient
                Image("rocket-small")
                    .resizable()
                    .scaledToFit()
                
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: widgetFamily != .systemSmall ? 56 : 36,
                           height: widgetFamily != .systemSmall ? 56 : 36)
                    .offset(x: (geometry.size.width / 2) - 20 ,
                            y: (geometry.size.height / -2) + 20)
                    .padding(.top, widgetFamily != .systemSmall ? 32 : 12)
                    .padding(.trailing, widgetFamily != .systemSmall ? 32 : 12)
                
                HStack {
                    Text("Just do it")
                        .foregroundColor(.white)
                        .font(fontStyle)
                        .fontWeight(.bold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(
                            Color(red: 0,
                                  green: 0,
                                  blue: 0)
                            .blendMode(.overlay)
                        )
                    .clipShape(Capsule())
                    if widgetFamily != .systemSmall{
                        Spacer()
                    }
                }//: HSTACK
                .padding()
                .offset(y: (geometry.size.height / 2) - 24)
            }//: ZSTACK
        }//: GEOMETRY READER
    }
}

//MARK: - MAIN
@main
struct DevoteWidget: Widget {
    let kind: String = "DevoteWidget"
    
    //MARK: - WIDGET MAIN BODY
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DevoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Devote Launcher")
        .description("This is an example widget for the personal task manager.")
    }
}

//MARK: - PREVIEW
struct DevoteWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            DevoteWidgetEntryView(entry: SimpleEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
