import Foundation

struct Ride: Identifiable {
    let name: String
    let id: String
    let latitude: Double
    let longitude: Double
    let waitTime: Int
    let duration: Int
    
    // Designated initializer with default parameter values
    init(name: String, id: String, latitude: Double, longitude: Double, waitTime: Int = 0, duration: Int = 0) {
        self.name = name
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.waitTime = waitTime
        self.duration = duration
    }
}


class SelectedRidesManager: ObservableObject {
    static let shared = SelectedRidesManager()
    
    @Published  var selectedRides: [Ride] = []
    
    private init() {}
    
    func addSelectedride(_ rideName: String) {
        let newRide = Ride(name: rideName, id: rideName, latitude: 1, longitude: 1)
        selectedRides.append(newRide)
    }
    
    func removeSelectedride(_ rideName: String) {
        selectedRides.removeAll(where: { $0.name == rideName })
    }
    
    func getSelectedRides() -> [Ride] {
        return selectedRides
    }
}

