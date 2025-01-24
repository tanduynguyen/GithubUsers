//
//  WebView.swift
//  GithubUsers
//
//  Created by Duy Nguyen on 24/1/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {

        let request = URLRequest(url: url)
        webView.load(request)
    }
}

struct WebviewPopup: View {
    let url: URL?
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            NavigationStack {
                if let url = url {
                    WebView(url: url)
                } else {
                    Text("No URL available")
                }
            }
            .navigationBarTitle(Text("WebView"), displayMode: .inline)
            .navigationBarItems(trailing: Button("Done",
                                                 action: {
                isPresented.toggle()
            }))
        }
    }
}
