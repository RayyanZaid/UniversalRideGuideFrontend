

import FirebaseFirestore



func setSelectedRidesInFirebase(selectedRides: [String], email: String) {
    
    
    let db = Firestore.firestore()
    
    let userRef = db.collection("users").document(email)
    
    // Set the "rides" field in the Firestore document with the selectedRides array
    userRef.setData(["rides": selectedRides], merge: true) { error in
        if let error = error {
            print("Error setting rides in Firestore: \(error.localizedDescription)")
        } else {
            print("Rides successfully updated in Firestore.")
        }
    }
}


