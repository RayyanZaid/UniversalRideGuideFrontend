//
//  FirebaseFunctionsGetters.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import FirebaseFirestore

let db = Firestore.firestore()


func getSelectedRides(email : String) -> [String] {
    
    return ["Revenge of the Mummy" , "Dispicable Me Mayhem" , "Flight of the Hippogriff"];
}


