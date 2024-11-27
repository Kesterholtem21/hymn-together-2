//
//  WebView.swift
//  HymnTogether
//
//  Created by Liam Grossman on 11/11/24.
//
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: self.url) {
            uiView.load(URLRequest(url: url))
        } else {
            uiView.load(URLRequest(url: URL(string: self.url)!  ))
        }
    }
}

#Preview {
    WebView(url: "https://google.com")
}
