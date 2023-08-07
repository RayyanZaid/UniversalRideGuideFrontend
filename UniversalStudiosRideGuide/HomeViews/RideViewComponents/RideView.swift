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
                RideRow(ride: ride, isSelected: binding(for: ride)) // Update parameter name here
            }
            .listStyle(PlainListStyle())
        }
        .onAppear {
            RidesFromFirestore.shared.fetchRides { rides in
                self.allRides = rides
            }
        }
    }
    
    // Helper function to get the binding for isRideSelected property
    private func binding(for ride: Ride) -> Binding<Bool> {
        Binding<Bool>(
            get: {
                return selectedRidesManager.getSelectedRides().contains(where: { $0.id == ride.id }) // Add 'where:' label
            },
            set: { newValue in
                if newValue {
                    selectedRidesManager.addSelectedride(ride)
                    print(selectedRidesManager.selectedRides)
                } else {
                    selectedRidesManager.removeSelectedride(ride.id)
                }
            }
        )
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
                
                Text(String(isSelected)) // Use the local binding value

            }
        }
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.1)
        .padding()
    }
}


#Preview {
    RideView(email: "")
}
