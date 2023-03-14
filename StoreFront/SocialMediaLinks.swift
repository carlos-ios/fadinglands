//
//  SocialMediaLinks.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/16/23.
//

import SwiftUI

struct SocialMediaLinks: View {
    var body: some View {
        VStack {
            
            Link(destination: URL(string: "https://instagram.com/company_of_the_fading_lands?igshid=YmMyMTA2M2Y=")!)
            {
                Image("Instagram_logo").resizable().frame(width: 200, height: 200)
            }
            
            Link(destination: URL(string: "https://www.facebook.com/groups/companyofthefadinglands")!)
            {
                Image("facebook_logo").resizable().frame(width: 200, height: 100)
            }.padding(.bottom, 15)
            
            Link(destination: URL(string: "https://discord.com/channels/985899791907192862/985899792376926290")!)
            {
                Image("discord_logo").resizable().frame(width: 200, height: 100)
            }
        }
    }
}


//https://discord.com/channels/985899791907192862/985899792376926290
struct SocialMediaLinks_Previews: PreviewProvider {
    static var previews: some View {
        SocialMediaLinks()
    }
}
