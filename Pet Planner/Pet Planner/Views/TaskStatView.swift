//
//  TaskStatView.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 16.10.2023.
//

import SwiftUI

struct TaskStatView: View {
    
    let title: String
    var count: Int?
    let icon: String
    
    let chevronIcon = UIImage(named: "nav-arrow-right")
    
    var body: some View {
            HStack(spacing: 4) {
                Text(title)
                    .font(.system(size: 12))
                    .opacity(1.0)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                Image(uiImage: chevronIcon!)
            }
    }
}

