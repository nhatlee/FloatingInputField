//
//  TextInputFieldClearButtonHidden.swift
//  MyTextInputField
//
//  Created by Nhat Le on 23/8/24.
//

import Foundation
import SwiftUI

private struct TextInputFieldClearButtonHidden: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var clearButtonHidden: Bool {
        get { self[TextInputFieldClearButtonHidden.self] }
        set { self[TextInputFieldClearButtonHidden.self] = newValue }
    }
}


extension View {
    public func clearButtonHidden(_ hidesClearButton: Bool = false) -> some View {
        environment(\.clearButtonHidden, hidesClearButton)
    }
}
