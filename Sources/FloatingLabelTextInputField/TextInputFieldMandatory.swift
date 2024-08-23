//
//  TextInputFieldMandatory.swift
//
//
//  Created by Nhat Le on 23/8/24.
//

import Foundation
import SwiftUI

private struct TextInputFieldMandatory: EnvironmentKey {
    static var defaultValue: Bool = false
}

extension EnvironmentValues {
    var isMandatory: Bool {
        get { self[TextInputFieldMandatory.self] }
        set { self[TextInputFieldMandatory.self] = newValue }
    }
}

extension View {
    public func isMandatory(_ value: Bool = true) -> some View {
        environment(\.isMandatory, value)
    }
}
