//
//  SessionsListItemView.swift
//  Focus
//
//  Created by Jack Radford on 24/01/2024.
//

import SwiftUI

struct SessionsListItemView: View {
    @ObservedObject var session: Session
    
    init(_ session: Session) {
        self.session = session
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Start  \(session.startDateString)")
                Text("End    \(session.endDateString)")
            }
            Spacer()
            Text(session.duration)
        }
    }
}

#Preview {
    let session = Session(
        start: Date.now,
        end: Date.now,
        insertInto: PersistenceController.previewMoc
    )
    return SessionsListItemView(session)
}
