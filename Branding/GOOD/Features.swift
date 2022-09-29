//
// Copyright (c) 2017-2020 Cliqz GmbH. All rights reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at https://mozilla.org/MPL/2.0/.
//

import Shared
import SwiftyJSON
import CoreGraphics

extension Features.BrowserCore {
    public static var configUrl: String {
        return ""
    }
}

extension Features.Search.AdditionalSearchEngines {
    public static var isEnabled: Bool {
        return false
    }
}

extension Features.Search {
    public static var keyboardReturnKeyBehavior: Features.Search.KeyboardReturnKeyBehavior {
        return .search
    }
    public static var defaultEngineName: String {
        return "GOOD"
    }
}

extension Features.Search.QuickSearch {
    public static var isEnabled: Bool {
        return false
    }
}

extension Features.ControlCenter.PrivacyStats.SearchStats {
    public static var isEnabled: Bool {
        return false
    }
}

extension Features.Home.DynamicBackgrounds {
    public static var isEnabled: Bool {
        return false
    }
}

extension Features.Home.SearchBar {
    public static var reactCornerRadius: CGFloat {
        return 10.0
    }
    public static var iOSCornerRadius: CGFloat {
        return 8.0
    }
    public static var widthPercent: String {
        return "85%"
    }
    public static var borderWidth: CGFloat {
        return 1.0
    }
    public static var borderColor: UIColor {
        return .gray
    }
}

extension Features.Home.Banner {
    public static var isBig: Bool {
        return false
    }
}

extension Features.Home.TopSites {
    public static var isEnabled: Bool {
        return false
    }
}

extension Features.HumanWeb {
    public static var isEnabled: Bool {
        return false
    }
    public static var collectorDirectUrl: String {
        return ""
    }
    public static var collectorProxyUrl: String {
        return ""
    }
}

extension Features.Telemetry {
    public static var isEnabled: Bool {
        return false
    }
}

extension Features.PrivacyDashboard.ReportPage {
    public static var isEnabled: Bool {
        return false
    }
}

extension Features.PrivacyDashboard {
    public static var isAdBlockingEnabled: Bool {
        return false
    }
}

extension Features.ContentBlocker {
    public static var excludeURLs: [String] {
        return ["good-search.org", "www.good-search.org"]
    }
}

extension Features.DefaultBrowserHint {
    public static var isEnabled: Bool {
        return true
    }
}

extension Features.AutoSuggestion {

    public static func parse(json: JSON) -> ([String], [[String: Any]]) {
        guard let jsonArray = json.arrayObject else {
            return ([], [[:]])
        }
        var mappedQueries = [String]()
        var query: String?
        for array in jsonArray {
            if let queryArg = array as? String {
                query = queryArg
            } else if let stringArray = array as? [String] {
                mappedQueries.append(contentsOf: stringArray)
                break
            }
        }
        if let query = query, !mappedQueries.contains(query) {
            mappedQueries.insert(query, at: 0)
        }
        return (mappedQueries, [[:]])
    }

}
