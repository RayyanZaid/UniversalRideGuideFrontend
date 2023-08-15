import Foundation
import CoreLocation

struct Ride: Identifiable {
    let name: String
    let id: String
    let coordinates : CLLocationCoordinate2D
    let waitTimes: [Int]
    let duration: Int
    
    
    // Designated initializer with default parameter values
    init(name: String, id: String, coordinates: CLLocationCoordinate2D, waitTimes: [Int], duration : Int) {
        self.name = name
        self.id = id
        self.coordinates = coordinates
        self.waitTimes = waitTimes
        self.duration = duration
    }
}


class SelectedRidesManager: ObservableObject {
    static let shared = SelectedRidesManager()
    
    @Published  var selectedRides: [Ride] = []
    @Published var allRides : [Ride] = []
    
    private init() {}
    
    func addSelectedride(_ ride: Ride) {
        
        if !selectedRides.contains(where: { $0.name == ride.name }) {
                    selectedRides.append(ride)
                }
    }
    
    func removeSelectedride(_ rideName: String) {
        selectedRides.removeAll(where: { $0.name == rideName })
    }
    
 
    
    func setAllRides() -> Void {
        
        setAllRidesFromFirebase { rides in
            self.allRides = rides
//            print(self.allRides[0].name)
        }
    }

}

