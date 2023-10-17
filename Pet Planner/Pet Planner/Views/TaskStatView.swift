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
    
    var body: some View {
            HStack {
                HStack(spacing: 10) {
                    
                    Image(systemName: "checkmark.circle")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)  // değişecek
                    
                    if let count {
                        Text("\(count)")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                    }

                    Text(title)
                        .font(.system(size: 14))
                        .opacity(1.0)
                        .foregroundColor(.black)
                }
                Spacer()
                
               
            }.padding()
                .frame(maxWidth: .infinity)
                .background(.white)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 16.0).stroke(Color.gray, lineWidth: 1))
    }
}

#Preview {
    TaskStatView(title: "isDone", count: 9)
}
