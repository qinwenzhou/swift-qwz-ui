//
//  WebView.swift
//  swift-qwz-ui
//
//  Created by david on 2025/12/10.
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    public let url: URL?
    public let configuration: ((WKWebView) -> Void)?
    
    public init(url: URL?, configuration: ((WKWebView) -> Void)? = nil) {
        self.url = url
        self.configuration = configuration
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        self.configuration?(webView)
        return webView
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = self.url else { return }
        let urlString = url.absoluteString
        
        if urlString.hasPrefix("https://") || urlString.hasPrefix("http://") {
            let request = URLRequest(
                url: url,
                cachePolicy: .reloadRevalidatingCacheData,
                timeoutInterval: 60)
            uiView.load(request)
            
        } else if urlString.hasPrefix("local://") {
            let dirUrl = url.deletingLastPathComponent()
            uiView.loadFileURL(url, allowingReadAccessTo: dirUrl)
            
        } else if urlString.hasPrefix("file://") {
            let dirUrl = url.deletingLastPathComponent()
            uiView.loadFileURL(url, allowingReadAccessTo: dirUrl)
        }
    }
}
