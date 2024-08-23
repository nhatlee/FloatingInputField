//
//  TextInputFieldValidationHandler.swift
//  MyTextInputField
//
//  Created by Nhat Le on 23/8/24.
//

import Foundation
import SwiftUI

public enum ValidationError: Error {
    case invalidEmail
    
    var message: String {
        switch self {
        case .invalidEmail:
            return "Email is invalid"
        }
    }
}

private struct TextInputFieldValidationHandler: EnvironmentKey {
    static var defaultValue: ((String) -> Result<Bool, ValidationError>)?
}

extension EnvironmentValues {
    var validationHandler: ((String) -> Result<Bool, ValidationError>)? {
        get { self[TextInputFieldValidationHandler.self] }
        set { self[TextInputFieldValidationHandler.self] = newValue }
    }
}

extension View {
    public func onValidate(validationHandler: @escaping (String) -> Result<Bool, ValidationError>) -> some View {
        environment(\.validationHandler, validationHandler)
    }
}
