//
//  FirebaseFunctionsGetters.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import FirebaseFirestore

let db = Firestore.firestore()


func getSelectedRides(email : String) -> [String] {
    
    return ["Ride1" , "Dispicable Me Mayhem" , "Flight of the Hippogriff", "Ride4" , "rid5" , "rid6" , "ride7"];
}


