//
//  RideScheduleBox.swift
//  UniversalStudiosRideGuide
//
//  Created by Rayyan Zaid on 8/4/23.
//

import SwiftUI

struct RideScheduleBox: View {
    
    @State var rideScheduleArray: [String] = getOptimalRoute()
    
    let rideButtonWidth = UIScreen.main.bounds.width * 0.5
    let rideButtonHeight = UIScreen.main.bounds.height * 0.2
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 25)
                .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.6)
                .foregroundColor(.white)
                .shadow(radius: 60)
            
            ScrollView {
                VStack(spacing: 10) {
                    Text("Your Next Ride")
                        .font(.headline)
                        .padding(.top, 10)
                    Button(action: {
                        if let firstRide = rideScheduleArray.first {
                            print(firstRide)
                        }
                    }) {
                        if let firstRide = rideScheduleArray.first {
                            HStack {
                                Text(firstRide)
                                    .padding()
                                    .foregroundColor(.black)
                           
                          
               
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.black)
                                    .padding()
                            }.background(Color.cyan)
                                .cornerRadius(20)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Up Next")
                        .font(.headline)
                        .padding(.top, 10)
                    ForEach(rideScheduleArray.dropFirst(), id: \.self) { ride in
                        Button(action: {
                            print(ride)
                        }) {
                            HStack {
                                Text(ride)
                                    .padding()
                                    .foregroundColor(.black)
                                    
                                    .cornerRadius(10)
              
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.black)
                                    .padding()
                            }.background(Color.cyan)
                                .cornerRadius(20)
                        }
                    }.padding()
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
