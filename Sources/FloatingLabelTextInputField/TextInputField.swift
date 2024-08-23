//
//  TextInputField.swift
//
//
//  Created by Nhat Le on 23/8/24.
//

import SwiftUI
import UIKit

public struct TextInputField: View {
    // Environment key
    @Environment(\.clearButtonHidden) var clearButtonHidden
    @Environment(\.isMandatory) var isMandatory
    @Environment(\.validationHandler) var validationHandler
    
    // Values initial
    private var title: String
    @Binding private var text: String
    @Binding private var isValidBinding: Bool
    
    
    // local State variable
    @State private var isValid: Bool = true {
        didSet {
            isValidBinding = isValid
        }
    }
    @State private var validationMessage: String = ""
    
    private var clearButtonPadding: CGFloat {
      !clearButtonHidden ? 25 : 0
    }
    
    public init(
        _ title: String,
        text: Binding<String>,
        isValid isValidBinding: Binding<Bool>? = nil
    ) {
        self.title = title
        self._text = text
        self._isValidBinding = isValidBinding ?? .constant(true)
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            if !isValid {
                Text(validationMessage)
                    .foregroundStyle(.red)
                    .offset(y: -25)
                    .scaleEffect(0.8, anchor: .leading)
            }
            if (text.isEmpty || isValid) {
                Text(title)
                    .foregroundStyle(text.isEmpty ? Color(.placeholderText) : .accentColor)
                    .offset(y: text.isEmpty ? 0 : -25)
                    .scaleEffect(text.isEmpty ? 1: 0.8, anchor: .leading)
            }
            TextField("", text: $text)
                .onAppear {
                    validate(text)
                }
                .onChange(of: text) { value in
                    validate(value)
                }
                .padding(.trailing, clearButtonPadding)
                .overlay(clearButton)
                
        }
        .padding(.top, 15)
        .animation(.default, value: text)
    }
    
    private var clearButton: some View {
        HStack {
            if !clearButtonHidden {
                Spacer()
                Button(action: {text = ""}) {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundStyle(Color(UIColor.systemGray))
                }
            } else {
                EmptyView()
            }
        }
    }
}

extension TextInputField {
    fileprivate func validate(_ value: String) {
        if isMandatory {
            isValid = !value.isEmpty
            validationMessage = isValid ? "" : "This is a mandatory field"
        }
        guard isValid else { return }
        guard let validationHandler = validationHandler else { return }
        let validationResult = validationHandler(value)
        switch validationResult {
        case .success(let isValid):
            self.isValid = isValid
            self.validationMessage = ""
        case .failure(let error):
            self.isValid = false
            validationMessage = "\(error.message)"
        }
    }
}

#Preview {
    @State var text = ""
    return TextInputField("title", text: $text)
}



// MARK: - Component Library

@available(iOS 15.0, *)
public struct TextInputField_Library: LibraryContentProvider {
  public var views: [LibraryItem] {
    [LibraryItem(TextInputField("First Name", text: .constant("Peter")),
                 title: "TextInputField",
                 category: .control)]
  }

  public func modifiers(base: TextInputField) -> [LibraryItem] {
    [LibraryItem(base.clearButtonHidden(true), category: .control)]
  }
}
