//
//  FirebaseFunctionsGetters.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import FirebaseFirestore

let db = Firestore.firestore()


func getSelectedRides(email : String) -> [String] {
    
    return ["Ride 1" , "Ride 2"];
}


