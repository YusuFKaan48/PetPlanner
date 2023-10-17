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
    
    var body: some View {
            HStack {
                HStack(spacing: 10) {
                    
                    Image(systemName: icon)
                        .font(.title)
                        .fontWeight(.regular)
                        .foregroundColor(Color(.sRGB, red: 224/255, green: 224/255, blue: 224/255, opacity: 1.0))
                        .padding(.leading, 16)
                    
                    if let count {
                        Text("\(count)")
                            .font(.system(size: 14))
                            .foregroundColor(.black)
                            .fontWeight(.medium)
                            
                    }

                    Text(title)
                        .font(.system(size: 14))
                        .opacity(1.0)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
                Spacer()
                
               
            }
            .frame(width: 158, height: 70) 

            .background(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color(.sRGB, red: 224/255, green: 224/255, blue: 224/255, opacity: 1.0), lineWidth: 1)
            )
            .padding()
            .foregroundColor(Color.black)
    }
}

#Preview {
    TaskStatView(title: "isDone", count: 9, icon: "circle")
}
