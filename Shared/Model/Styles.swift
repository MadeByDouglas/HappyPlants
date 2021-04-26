//
//  Styles.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(configuration.isPressed ? Color.gray : Color.blue)
            .cornerRadius(16.0)
            .frame(minWidth: 180, maxWidth: .infinity, minHeight: 44)
    }
}
