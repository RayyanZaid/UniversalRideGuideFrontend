//
//  LandingView.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import SwiftUI

struct LandingView: View {
    
    
    var email : String
    @State private var username : String = "Rayyan"
    
    init(email : String) {
        self.email = email
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
        .onAppear {
            getUsername(forEmail: email) { retrievedUsername in
                self.username = retrievedUsername
            }
        }
        
        // Uncomment the onAppear when using the Simulator.
        // For some reason firebase getUsername function doesn't work with the Live Preview
        
        
            
        
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
