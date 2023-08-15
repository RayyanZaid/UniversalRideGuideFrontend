//
//  FirebaseFunctionsGetters.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import FirebaseFirestore
import CoreLocation




func fetchSelectedRidesFromFirebase(email: String, completion: @escaping ([String]) -> Void) {

    let db = Firestore.firestore()
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

func setAllRidesFromFirebase(completion: @escaping ([Ride]) -> Void) {
    
    let db = Firestore.firestore()
    let allRidesDatabaseRef = db.collection("rides")
    
    allRidesDatabaseRef.getDocuments { (querySnapshot, error) in
        if let error = error {
            print("Error fetching rides: \(error)")
            completion([])
            return
        }
        
        var rides: [Ride] = []
        
        for document in querySnapshot!.documents {
            if let rideData = document.data() as? [String: Any] {
                // Parse the ride data and create a Ride object
                if let name = rideData["name"] as? String,
                   let id = rideData["name"] as? String,
                   let waitTimes = rideData["waitTimes"] as? [Int],
                   let geoPoint = rideData["coordinates"] as? GeoPoint,
                   let duration = rideData["duration"] as? Int {
                    
                    let coordinates = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
                    let ride = Ride(name: name, id: id, coordinates: coordinates, waitTimes: waitTimes, duration: duration)
                    
                    rides.append(ride)
                }
            }
        }
        
        completion(rides)
    }
}

func getRideObjectFromName(rideName: String, completion: @escaping (Ride) -> Void) {
    
    let db = Firestore.firestore()
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
    
    let db = Firestore.firestore()
    
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



