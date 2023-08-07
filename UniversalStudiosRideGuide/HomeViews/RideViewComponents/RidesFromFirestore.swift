import FirebaseFirestore
import CoreLocation

class RidesFromFirestore {
    static let shared = RidesFromFirestore()
    
    private let db = Firestore.firestore()
    private let ridesCollection = "rides"
    
    func fetchRides(completion: @escaping ([Ride]) -> Void) {
        db.collection(ridesCollection).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching rides: \(error)")
                completion([])
            } else {
                var rides: [Ride] = []
                
                var name : String = ""
                var id : String = ""
                
                var coordinates : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 1, longitude: 1)
                
                var geoPoint : GeoPoint
                
                
                var waitTimes : [Int] = []
                
                var duration : Int = 0
                
                
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    
                    if data["name"] != nil {
                        name = data["name"] as! String;
                        id = data["name"] as! String;
                    }
                    
                    else {
                        name = "None"
                    }
                    
                    if data["coordinates"] != nil {
                        geoPoint = data["coordinates"] as! GeoPoint
                        coordinates = CLLocationCoordinate2D(latitude: geoPoint.latitude, longitude: geoPoint.longitude)
                    }
                    
                    if data["waitTime"] != nil {
                        waitTimes = data["waitTime"] as! [Int]
                    }
                    
                    if data["duration"] != nil {
                        duration = data["duration"] as! Int
                    }
                    
                    var newRide = Ride(name: name, id: id, coordinates: coordinates, waitTimes: waitTimes , duration: duration)
                    
                    rides.append(newRide)
                    
                }
                completion(rides)
            }
        }
    }
}
