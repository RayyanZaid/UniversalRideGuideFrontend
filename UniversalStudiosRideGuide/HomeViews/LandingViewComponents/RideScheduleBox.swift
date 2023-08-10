//
//  RideScheduleBox.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import SwiftUI

struct RideScheduleBox: View {
    
    @State var rideScheduleArray: [Ride] = []
    
    let rideButtonWidth = UIScreen.main.bounds.width * 0.5
    let rideButtonHeight = UIScreen.main.bounds.height * 0.2
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 25)
                .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.6)
                .foregroundColor(.white)
                .shadow(radius: 60)
            
            
                VStack(spacing: 10) {
                    Text("Your Next Ride")
                        .font(.headline)
                        .padding(.top, 10)
                    Button(action: {
                        if let firstRide = rideScheduleArray.first {
                            print(firstRide.name)
                        }
                    }) {
                        if let firstRide = rideScheduleArray.first {
                            HStack {
                                Text(firstRide.name)
                                    .padding()
                                    .foregroundColor(.black)
                                
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.black)
                                    .padding()
                            }
                        }
                    }

                    
                    Spacer()
                    
                    Text("Up Next")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    ScrollView {
                        ForEach(rideScheduleArray.dropFirst(), id: \.id) { ride in
                            Button(action: {
                                print(ride)
                            }) {
                                HStack {
                                    Text(ride.name)
                                        .padding()
                                        .foregroundColor(.black)
                                        .cornerRadius(10)
                                    
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.black)
                                        .padding()
                                }
                            }
                            .background(Color.cyan)
                            .cornerRadius(20)
                            .padding()
                        }
                    }

            }.frame(maxHeight: UIScreen.main.bounds.height * 0.5)
            
        }
    }
}


struct RideScheduleBox_Previews: PreviewProvider {
    static var previews: some View {
        RideScheduleBox()
    }
}


#Preview {
    RideScheduleBox()
}
