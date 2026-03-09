//
//  NoDataView.swift
//  iPrompt
//
//  Created by david on 2026/1/27.
//

import SwiftUI

public struct NoDataView: View {
    public var text: String?
    public var image: Image
    public var foregroundColor: Color
    
    public init(
        text: String? = nil,
        image: Image? = nil,
        foregroundColor: Color? = nil
    ) {
        self.text = text
        self.image = image ?? Image(systemName: "tray")
        self.foregroundColor = foregroundColor ?? Color.qwz.textSecondary
    }
    
    public var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundStyle(Color.qwz.textSecondary)
            
            if let text {
                Text(text)
                    .font(.body)
                    .foregroundStyle(Color.qwz.textSecondary)
            }
        }
    }
}
