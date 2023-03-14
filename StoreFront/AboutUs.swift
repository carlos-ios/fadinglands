//
//  StoreInfo.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/16/23.
//

import SwiftUI
import WebKit

struct AboutUs: View {
    let webView = WKWebView()
    
    
    var body: some View {
        WebView(url: "https://docs.google.com/document/d/1mVh6hncPSRnGGZCJazMBr3dx4mRtOoPhSFGaKyskhwA/edit")
    }
}


struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
    }
}
