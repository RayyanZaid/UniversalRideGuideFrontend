//
//  FirebaseFunctionsGetters.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import FirebaseFirestore
import CoreLocation

let db = Firestore.firestore()


func fetchSelectedRidesFromFirebase(email: String, completion: @escaping ([String]) -> Void) {

    let rideDatabaseRef = db.collection("users").document(email)

    rideDatabaseRef.getDocument { (documentSnapshot, error) in
        if let error = error {
            print("Error fetching document: \(error)")
            completion([])
        } else if let document = documentSnapshot, document.exists {
            if let selectedRides = document.data()?["rides"] as? [String] {
            
                completion(selectedRides)
            } else {
                
                completion([])
            }
        } else {
            print("Document does not exist")
            completion([])
        }
    }
}

func getRideObjectFromName(rideName: String, completion: @escaping (Ride) -> Void) {
    
    let rideDatabaseRef = db.collection("rides").document(rideName)
    
    rideDatabaseRef.getDocument { (documentSnapshot , error) in
        
        if let error = error {
            print("Error fetching document: \(error)")
        }
        
        else if let document = documentSnapshot , document.exists {
            
            
            let name : String = document.data()?["name"] as! String
            let id : String = document.data()?["name"] as! String
            let waitTimes : [Int] = document.data()?["waitTimes"] as! [Int]
            
            let geoPoint : GeoPoint = document.data()?["coordinates"] as! GeoPoint
            let coordinates : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
            
            let duration = document.data()?["duration"] as! Int
            
            let rideObject : Ride = Ride(name: name, id: id, coordinates: coordinates, waitTimes: waitTimes, duration: duration)
            
            return completion(rideObject)
            
            

            
       
        

            
            
        }
    }
}

func getUsername(forEmail email: String, completion: @escaping (String) -> Void) {
    let userRef = db.collection("users").document(email)
    
    print("Querying Firestore for email: \(email)")
    
    userRef.getDocument { document, error in
        if let error = error {
            print("Error getting document: \(error)")
            completion("") // Call the completion handler with an empty string in case of an error
            return
        }
        
        if let document = document, document.exists {
            if let usernameFromDB = document.data()?["username"] as? String {
                completion(usernameFromDB) // Call the completion handler with the retrieved username
            }
        } else {
            print("Document does not exist")
            print("Logging in for the first time")
            completion("") // Call the completion handler with an empty string when the document doesn't exist
        }
    }
}



