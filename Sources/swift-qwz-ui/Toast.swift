//
//  Toast.swift
//  swift-qwz-ui
//
//  Created by david on 2025/8/12.
//

import SwiftUI

public struct Toast<T: View>: ViewModifier {
    @Binding public var isShowing: Bool
    public var customView: T
    
    public func body(content: Content) -> some View {
        content
            .overlay {
                if isShowing {
                    customView
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                isShowing = false
                            }
                        }
                }
            }
    }
}

extension View {
    public func toast<Content: View>(isShowing: Binding<Bool>, content: () -> Content) -> some View {
        self.modifier(Toast(isShowing: isShowing, customView: content()))
    }
}
