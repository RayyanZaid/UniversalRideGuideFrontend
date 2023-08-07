//
//  LandingView.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import SwiftUI

struct LandingView: View {
    
    
    var email : String
    var username : String
    
    init(email : String) {
        self.email = email
        self.username = "Rayyan"
    }
    
    
    var body: some View {
        
        let topBar = HStack {
            Text("Hello, \(username)")
                .font(
                    .custom("Chalkboard SE", size: UIScreen.main.bounds.width * 0.09).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "gearshape.fill")
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .frame(height: 70)
        .padding(.horizontal, 20)
        
        
        
            
        
        VStack {
            
            topBar
            Spacer()
            RideScheduleBox()
            Spacer()
        }

    }
}

#Preview {
    LandingView(email: "")
}
