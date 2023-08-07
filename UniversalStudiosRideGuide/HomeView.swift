//
//  HomeView.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/3/23.
//

import SwiftUI

struct HomeView: View {
    
    var email : String
    
    init(email : String) {
        self.email = email
    }
    
    @State private var selectedTab: TabItem = .home
    
    var body: some View {
        
        // Variables
        
        let background = Rectangle().fill(LinearGradient(gradient: Gradient(colors: [
            Color(red: 0.051, green: 0.196, blue: 0.302),
            Color(red: 0.498, green: 0.353, blue: 0.514)
        ]),
                                                         startPoint: .top,
                                                         endPoint: .bottom
        )).edgesIgnoringSafeArea(.all)
        
        
        let bottomNav = VStack {
            
            if selectedTab == .home {
                LandingView(email: self.email)
            }
            
            if selectedTab == .rides {
                RideView(email: email)
            }
            
            if selectedTab == .map {
                MapView()
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: UIScreen.main.bounds.height * 0.02 )
                    .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height * 0.11)
                    .foregroundColor(.white)
                    .shadow(radius: 50)
                
                HStack {
                    ForEach([TabItem.home, TabItem.rides, TabItem.map], id: \.self) { tab in
                        Button(action: {
                            selectedTab = tab
                        }) {
                            Image(systemName: tab.imageName)
                                .imageScale(.large)
                                .foregroundColor(selectedTab == tab ? .blue : .gray)
                                .padding(20)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
                
                
            }
        }.frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.container , edges: .bottom)
        
        
        
        
        // The actual view
        
        ZStack {
            
            background
            VStack {
                Spacer()
                bottomNav
            }
            
            
        }
    }
}



#Preview {
    HomeView(email: "")
}
