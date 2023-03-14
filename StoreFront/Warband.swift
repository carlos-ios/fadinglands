//
//  DealCampaigns.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/16/23.
//

import SwiftUI

struct Warband: View {
    private var photosInSlide = 10
    var body: some View {
        GeometryReader { proxy in
            TabView {
                ForEach(0..<photosInSlide) { num in
                    Image("\(num)")
                        .resizable()
                        .scaledToFill()
                        .tag(num)
                }
            }.tabViewStyle(PageTabViewStyle())
                .frame(width: proxy.size.width, height: proxy.size.height / 2.2)
                .padding(.top, 20)
        }
    }
}

struct Warband_Previews: PreviewProvider {
    static var previews: some View {
        Warband()
    }
}
