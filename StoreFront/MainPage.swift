//
//  MainPage.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/16/23.
//

import SwiftUI

struct MainPage: View {
    
    var body: some View {
        TabView {
            Text("main")
            CannabisInventory().tabItem {
                Label("Cannabis", systemImage: "leaf.circle.fill")
            }
            Profile().tabItem {
                Label("Profile", systemImage: "person.crop.circle")
            }
            StoreInfo().tabItem {
                Label("Store", systemImage: "house.fill")
            }
            DealCampaigns().tabItem {
                Label("Deals", systemImage: "lasso.and.sparkles")
            }
            SocialMediaLinks().tabItem {
                Label("Social", systemImage: "person.line.dotted.person.fill")
            }
            
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
