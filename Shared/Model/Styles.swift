//
//  Styles.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI

struct BigButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(configuration.isPressed ? Color.gray : Color.accentColor)
            .cornerRadius(16.0)
            .frame(minWidth: 180, maxWidth: .infinity, minHeight: 44)
    }
}
