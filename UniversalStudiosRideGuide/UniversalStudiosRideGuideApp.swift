//
//  UniversalStudiosRideGuideApp.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/2/23.
//

import SwiftUI
import Firebase
@main
struct UniversalStudiosRideGuideApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
