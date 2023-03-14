//
//  MainPage.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/16/23.
//

import SwiftUI

struct MainPage: View {
    init() {
        UITabBar.appearance().itemPositioning = .centered
        UITabBar.appearance().selectedItem?.badgeColor = .systemBlue
    }
    var body: some View {
        
        TabView() {
           
            Text("main")
//            CannabisInventory().tabItem {
//                Label("Cannabis", systemImage: "leaf.circle.fill")
//            }
            Profile().tabItem {
                Label("Chat", systemImage: "person.crop.circle")
            }
            AboutUs().tabItem {
                Label("Charter", systemImage: "house.fill")
            }
            Warband().tabItem {
                Label("Warband", systemImage: "lasso.and.sparkles")
            }
            SocialMediaLinks().tabItem {
                Label("Social", systemImage: "person.line.dotted.person.fill")
            }
            Events().tabItem {
                Label("Events", systemImage: "calendar")
            }
            
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
