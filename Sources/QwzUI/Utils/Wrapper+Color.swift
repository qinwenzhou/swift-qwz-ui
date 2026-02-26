//
//  Color+Extensions.swift
//  swift-qwz-ui
//
//  Created by david on 2026/2/26.
//

import SwiftUI

extension Color: Compatible {}

extension Wrapper where Base == Color {
    static var textSecondary: Color {
        return Color("TextSecondaryColor", bundle: .module)
    }
}
