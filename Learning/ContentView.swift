//
//  ContentView.swift
//  Learning
//
//  Created by itiw-mac 256 on 10/3/22.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    var body: some View {
        ZStack{
            BackgroundView(isNight: $isNight)
            VStack{
                CityNameView(isNight: $isNight).padding(.top)
                CurrentWeatherStatusView(isNight: $isNight)
                Spacer()
                WeekDaysWeatherStatusView(isNight: $isNight)
                Spacer()
                Button{
                    isNight.toggle()
                }label: {
                    DayNightModeChangeView(isNight: $isNight)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BackgroundView: View {
    @Binding var isNight : Bool
    var body: some View {
        LinearGradient(colors: [.blue, isNight ? Color("NightBGolor") :.white], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
    }
}

struct CityNameView: View {
    
    @Binding var isNight : Bool
    var body: some View {
        Text("Dhaka, BD").font(.system(size: 25)) .foregroundColor(isNight ? .white: .black)
    }
}

struct CurrentWeatherStatusView: View {
    @Binding var isNight : Bool
    var body: some View {
        VStack{
            Image(systemName: isNight ? "cloud.moon.fill":"cloud.sun.fill").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 150, alignment: .center)
            Text("\(isNight ? 27 : 32)°")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(isNight ? .white: .black)
                .padding(.bottom)
        }
    }
}

struct WeekDaysWeatherStatusView: View {
    
    @Binding var isNight : Bool
    var body: some View {
        HStack{
            VStack{
                Text("Sun").font(.system(size: 18)) .foregroundColor(isNight ? .white: .black)
                Image(systemName: "cloud.sun.fill").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40, alignment: .center)
                
                Text("35°").font(.system(size: 18)) .foregroundColor(isNight ? .white: .black)
            }
            VStack{
                Text("Mon").font(.system(size: 18)) .foregroundColor(isNight ? .white: .black)
                Image(systemName: "cloud.fill").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40, alignment: .center)
                
                Text("33°").font(.system(size: 18)) .foregroundColor(isNight ? .white: .black)
            }
            VStack{
                Text("Tue").font(.system(size: 18)) .foregroundColor(isNight ? .white: .black)
                Image(systemName: "sun.max.fill").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40, alignment: .center)
                
                Text("37°").font(.system(size: 18)) .foregroundColor(isNight ? .white: .black)
            }
            VStack{
                Text("Wed").font(.system(size: 18)) .foregroundColor(isNight ? .white: .black)
                Image(systemName: "cloud.drizzle.fill").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40, alignment: .center)
                
                Text("31°").font(.system(size: 18)) .foregroundColor(isNight ? .white: .black)
            }
            VStack{
                Text("Thu").font(.system(size: 18)) .foregroundColor(isNight ? .white: .black)
                Image(systemName: "cloud.sun.bolt.fill").renderingMode(.original).resizable().aspectRatio(contentMode: .fit).frame(width: 40, height: 40, alignment: .center)
                
                Text("39°").font(.system(size: 18)) .foregroundColor(isNight ? .white: .black)
            }
            
        }
    }
}

struct DayNightModeChangeView: View {
    
    @Binding var isNight : Bool
    var body: some View {
        Text("Toggle Day Night").foregroundColor(isNight ? .white: .black).font(.system(size: 20)).frame(width: 250, height: 70)
            .background(.blue).cornerRadius(10)
    }
}
