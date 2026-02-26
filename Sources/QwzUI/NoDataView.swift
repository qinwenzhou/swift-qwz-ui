//
//  NoDataView.swift
//  iPrompt
//
//  Created by david on 2026/1/27.
//

import SwiftUI

public struct NoDataView: View {
    public var label: String? = nil
    
    public var body: some View {
        VStack {
            Image(systemName: "tray")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundStyle(Color.qwz.textSecondary)
            
            if let label {
                Text(label)
                    .font(.body)
                    .foregroundStyle(Color.qwz.textSecondary)
            }
        }
    }
}

#Preview {
    NoDataView()
}
