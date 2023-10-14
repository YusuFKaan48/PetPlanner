//
//  ContentView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 6.10.2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView() {
            HomeView().tabItem {
                Label("Home", systemImage: "house")
            }

            TaskView().tabItem {
                Label("Task", systemImage: "calendar.badge.checkmark")
            }

            PetsView().tabItem {
                Label("Pets", systemImage: "suit.heart")
            }
        }
        .accentColor(Color(.sRGB, red: 24/255, green: 6/255, blue: 20/255, opacity: 0.8))
    }
}


#Preview {
    ContentView()
}
