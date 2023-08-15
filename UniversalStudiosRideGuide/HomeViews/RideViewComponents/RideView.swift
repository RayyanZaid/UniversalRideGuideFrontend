//
//  RideView.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import SwiftUI
import CoreLocation

struct RideView: View {
    
    @StateObject private var selectedRidesManager = SelectedRidesManager.shared
    
    @State var allRides: [Ride] = []
    @State var selectedRides: [String] = []
    
    var email : String
    
    init(email : String) {
        self.email = email
    }
    
    
    var body: some View {
        VStack {
            
            Text("Select Rides").font(
                .custom("Chalkboard SE", size: UIScreen.main.bounds.width * 0.09).bold())
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.white)
            
            
            
            
            List(allRides) { ride in
                RideRow(ride: ride, isSelected: Binding(
                    get: { self.selectedRides.contains(ride.name) },
                    set: { newValue in
                        if newValue {
                            print("Adding ride:", ride.name)
                            self.selectedRides.append(ride.name)
                        } else if let index = self.selectedRides.firstIndex(of: ride.name) {
                            print("Removing ride:", ride.name)
                            self.selectedRides.remove(at: index)
                        }
                    }

                ), selectedRides: $selectedRides)
                .background(.white)
            }


            .listStyle(PlainListStyle()).listRowSpacing(10)
            .frame(height: UIScreen.main.bounds.height * 0.45)
            
            
            
            
            
            Button(action: {
                print("Selected Rides Submit Button Clicked")
                print(self.selectedRides)
                
                setSelectedRidesInFirebase(selectedRides: self.selectedRides, email: self.email)
                
                
            }) {
                Text("Submit")
                    .font(.system(size: 20)) // Set a custom font size for the "Submit" text
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black.border(Color.black, width: 1))
                        .cornerRadius(20)
                        .padding(.horizontal, 5)
            }
            .padding(.vertical, 10)
            .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.2, alignment: .center)
            
        
        }.edgesIgnoringSafeArea(.all)
        .onAppear {
            allRides = selectedRidesManager.allRides
            fetchSelectedRidesFromFirebase(email: email) { selectedRidesFromFirebase in
                
                self.selectedRides = selectedRidesFromFirebase
                print(self.selectedRides)
                
            }
            
            if allRides.count == 0 {
                allRides = [
                    Ride(name: "Ride 1", id: "ride1", coordinates: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), waitTimes: [10, 15, 20], duration: 120),
                    Ride(name: "Ride 2", id: "ride2", coordinates: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437), waitTimes: [5, 8, 12], duration: 90),
                    Ride(name: "Ride 3", id: "ride3", coordinates: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060), waitTimes: [7, 10, 15], duration: 105),
                    Ride(name: "Ride 4", id: "ride4", coordinates: CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298), waitTimes: [12, 18, 25], duration: 150),
                    Ride(name: "Ride 5", id: "ride5", coordinates: CLLocationCoordinate2D(latitude: 39.9526, longitude: -75.1652), waitTimes: [8, 14, 22], duration: 135),
                    Ride(name: "Ride 6", id: "ride6", coordinates: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278), waitTimes: [6, 9, 14], duration: 100)
                ]
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
    @Binding var selectedRides: [String]

    init(ride: Ride, isSelected: Binding<Bool>, selectedRides: Binding<[String]>) {
        self.ride = ride
        self._isSelected = isSelected
        self._selectedRides = selectedRides
    }

    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Text(ride.name)
                    .font(.custom("Chalkboard SE", size: UIScreen.main.bounds.width * 0.05))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.black)
                Spacer()

                Button(action: {
                    isSelected.toggle()
                    if isSelected {
                        selectedRides.append(ride.name)
                    } else if let index = selectedRides.firstIndex(of: ride.name) {
                        selectedRides.remove(at: index)
                    }
                }) {
                    CircleColorView(isChecked: $isSelected)
                }

                Spacer()
                
                Text("\(isSelected ? "true" : "false")").foregroundColor(.black)

            }
            .background(.white)
            .padding()
        }
    }
}




#Preview {
    RideView(email: "")
}
