//
//  RideView.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import SwiftUI


struct RideView: View {
    @StateObject private var selectedRidesManager = SelectedRidesManager.shared
    @State var allRides: [Ride] = []
    
    var email : String
    
    init(email : String) {
        self.email = email
    }
    
    var body: some View {
        VStack {
            List(allRides) { ride in
                Text(ride.name)
            }
            .listStyle(PlainListStyle())
        }
        .onAppear {
            fetchSelectedRidesFromFirebase(email: email) { rides in 
                
                for ride in rides {
                    getRideObjectFromName(rideName: ride) { rideObj in
                        selectedRidesManager.addSelectedride(rideObj)
                    }
                }
                self.allRides = selectedRidesManager.getSelectedRides()
            }
        }
        
    }
    

   
}




struct CircleColorView: View {
    @Binding var isChecked : Bool
    
    
    var body : some View {
        Button(action: {
            isChecked.toggle()
        }) {
            ZStack {
                Circle().fill(isChecked ? Color.green : Color.gray)
                
                if isChecked {
                    Image(systemName: "checkmark").foregroundColor(.white)
                }
            }.frame(width: 50, height: 50)
        }
    }
}


struct RideRow: View {
    var ride: Ride
    @Binding var isSelected: Bool

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Text(ride.name)
                    .font(.custom("Chalkboard SE", size: UIScreen.main.bounds.width * 0.05))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.black)
                Spacer()

                CircleColorView(isChecked: $isSelected)

                Spacer()
                
                Text(String("hi")) // Use the local binding value

            }.background(.white)
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.1)
        .padding()
    }
}


#Preview {
    RideView(email: "")
}
