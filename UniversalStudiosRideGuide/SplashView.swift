//
//  SplashView.swift
//  AutoVolley
//
//  Created by Rayyan Zaid on 7/19/23.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false
    @StateObject private var selectedRidesManager = SelectedRidesManager.shared
    
    var body: some View {
        ZStack {
            if self.isActive {
                AuthView()
                // Change this to auth view
            } else {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                Text("Logo").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
        }.onAppear {
            selectedRidesManager.setAllRides()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}


struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
