//
//  HapticFeedback.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 13.12.2023.
//

import Foundation
import UIKit

func giveHapticFeedback() {
    let generator = UISelectionFeedbackGenerator()
    generator.prepare()
    generator.selectionChanged()
}
