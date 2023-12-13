//
//  AnimalEditConfig.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 27.10.2023.
//

import Foundation

struct AnimalEditConfig {
    var name: String = ""
    var picture: Data?
    
    
    
    init() { }
    
    init(animals: Animals) {
        name = animals.name ?? ""
        picture = animals.picture
    }
}

