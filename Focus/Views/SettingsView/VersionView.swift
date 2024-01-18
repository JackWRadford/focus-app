//
//  VersionView.swift
//  Focus
//
//  Created by Jack Radford on 18/01/2024.
//

import SwiftUI

struct VersionView: View {
    /// Infomation property list version
    let versionNumber = InfoPListValue(forKey: "CFBundleShortVersionString")
    /// Infomation property list build number
    let buildNumber = InfoPListValue(forKey: "CFBundleVersion")

    /// Get the value for the given Infomation property list key.
    /// - Parameter key: The key for the info.plist property.
    /// - Returns: A String representing the relevant info.plist value.
    private static func InfoPListValue(forKey key: String) -> String {
        return Bundle.main.object(forInfoDictionaryKey: key) as? String ?? ""
    }
    
    var body: some View {
        Text("Version \(versionNumber) (\(buildNumber))")
            .foregroundColor(.gray)
    }
}

#Preview {
    VersionView()
}
