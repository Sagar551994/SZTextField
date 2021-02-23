//
//  Validator.swift
//  SZTextField
//
//  Created by Harekrishna on 17/02/21.
//

import Foundation

public struct TextFieldValidator {
    public var condition: Bool = true
    public var errorMessage: String = ""
    
    public init(condition: Bool, errorMessage: String) {
        self.condition = condition
        self.errorMessage = errorMessage
    }
}
