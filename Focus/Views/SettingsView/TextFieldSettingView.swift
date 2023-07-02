//
//  TextFieldSettingView.swift
//  Focus
//
//  Created by Jack Radford on 29/06/2023.
//

import SwiftUI

struct TextFieldSettingView: View {
    
    var label: String
    @Binding var text: String
    
    @State private var editingText: String
    @FocusState private var focused
    
    init(label: String, text: Binding<String>) {
        self.label = label
        self._text = text
        self.editingText = text.wrappedValue
    }
    
    var body: some View {
        HStack {
            Text(label)
            TextField(text, text: $editingText)
                .focused($focused)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .onChange(of: focused) { newValue in
                    // Reset editingText value or update text value with new input value
                    if (!newValue) {
                        if (editingText.isEmpty) {
                            editingText = text
                        } else {
                            text = editingText
                        }
                    } else {
                        editingText = ""
                    }
                }
        }
    }
}

struct TextFieldSettingView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            Section("Test Section") {
                TextFieldSettingView(label: "Label",text: .constant("10"))
            }
        }
    }
}
