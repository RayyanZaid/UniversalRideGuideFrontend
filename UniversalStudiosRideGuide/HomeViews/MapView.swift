import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var selectedRidesManager = SelectedRidesManager.shared
    
    @State var count = 0;
    
    var body: some View {
        Map()
        
        Button(action: {
            selectedRidesManager.addSelectedride("Ride \(count)")
            count = count + 1;
            if selectedRidesManager.selectedRides.count != 0 {
                for ride in selectedRidesManager.selectedRides {
                    print(ride)
                }
            }
       
        }) {
            Text("Click here")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
