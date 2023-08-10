import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject var selectedRidesManager = SelectedRidesManager.shared
    
    @State var count = 0;
    
    var body: some View {
        
        Text("Map")
        
    
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
