//
// Copyright (c) 2017-2020 Cliqz GmbH. All rights reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import WidgetKit
import SwiftUI
import Shared

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(family: context.family)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(family: context.family)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let entries = [SimpleEntry(family: context.family)]
        let timeline = Timeline(entries: entries, policy: .never)
        completion(timeline)
    }

}

struct SimpleEntry: TimelineEntry {
    var date: Date = Date()
    let family: WidgetFamily
}

struct SearchEntryView: View {
    var entry: Provider.Entry

    private let deeplinkURL = URL(string: "\(AppInfo.protocolName)://search-widget?isPrivate=0")!

    var body: some View {
        VStack {
            Image("icon")
            Spacer()
            HStack {
                if self.entry.family == .systemMedium {
                    Text(Strings.UrlBar.Placeholder)
                        .foregroundColor(Color(.systemGray))
                }
                Spacer()
                Image("search")
            }
            .frame(height: 45.0)
            .padding(EdgeInsets(top: 0.0, leading: 15.0, bottom: 0.0, trailing: 15.0))
            .background(Color(.systemGray6))
            .cornerRadius(10.0)
        }
        .padding()
        .widgetURL(self.deeplinkURL)
    }
}

@main
struct Search: Widget {
    let kind: String = "Search"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: self.kind, provider: Provider()) { entry in
            SearchEntryView(entry: entry)
        }
        .configurationDisplayName(Strings.Search.Widget.ConfigurationDisplayName)
        .description(Strings.Search.Widget.Description)
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        SearchEntryView(entry: SimpleEntry(family: .systemMedium))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
