//
//  AnalyticsButtonView.swift
//  Focus
//
//  Created by Jack Radford on 18/01/2024.
//

import SwiftUI
import CoreData

struct AnalyticsButtonView: View {
    @Environment(\.managedObjectContext) private var moc
    @EnvironmentObject private var countdownVM: CountdownViewModel
    
    @StateObject private var analyticsVM: AnalyticsViewModel
    
    init(context: NSManagedObjectContext) {
        _analyticsVM = StateObject(wrappedValue: AnalyticsViewModel(moc: context))
    }
    
    var body: some View {
        NavigationLink {
            AnalyticsView(analyticsVM: AnalyticsViewModel(moc: moc))
        } label: {
            Image(systemName: "chart.pie.fill")
                .foregroundColor(countdownVM.isCounting ? .secondary : .primary)
        }
        .disabled(countdownVM.isCounting)
    }
}

#Preview {
    let previewContext = PersistenceController.previewMoc
    
    return AnalyticsButtonView(context: previewContext)
        .environment(\.managedObjectContext, previewContext)
        .environmentObject(CountdownViewModel(moc: previewContext))
}
