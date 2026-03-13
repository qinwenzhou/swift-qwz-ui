//
//  TextButton.swift
//  swift-qwz-ui
//
//  Created by david on 2026/3/13.
//

import SwiftUI

public struct TextButton: View {
    public var title: String
    public var action: () -> Void
    
    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            if #available(iOS 26.0, *) {
                Text(title)
                    .font(.body)
                    .padding(.horizontal, 24)
                    .frame(height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .glassEffect()
            } else {
                Text(title)
                    .font(.body)
                    .padding(.horizontal, 24)
                    .frame(height: 48)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 2)
            }
        }
    }
}
