//
//  SingleStatView.swift
//  Focus
//
//  Created by Jack Radford on 10/08/2023.
//

import SwiftUI

struct SingleStatView: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(value)
                .font(.title)
            Text(label)
                .foregroundColor(.secondary)
        }
    }
}

struct SingleStatView_Previews: PreviewProvider {
    static var previews: some View {
        SingleStatView(value: "6h 23m", label: "Total Time")
    }
}
