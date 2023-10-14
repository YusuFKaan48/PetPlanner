//
//  CustomOperators.swift
//  Pet Planner
//
//  Created by Yusuf Kaan USTA on 11.10.2023.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
