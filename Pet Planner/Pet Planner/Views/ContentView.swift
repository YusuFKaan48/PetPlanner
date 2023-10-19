//
//  ContentView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 6.10.2023.
//

import SwiftUI

struct ContentView: View {

    let homeIcon = UIImage(named: "home-simple")
    let taskIcon = UIImage(named: "heart")
    let petsIcon = UIImage(named: "clipboard-check")

    var body: some View {
        TabView() {
            HomeView().tabItem {
                Image(uiImage: homeIcon!)
                Text("Home")
            }

            TaskView().tabItem {
                Image(uiImage: taskIcon!)
                Text("Task")
            }

            PetsView().tabItem {
                Image(uiImage: petsIcon!)
                Text("Pets")
            }
        }
        .accentColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
