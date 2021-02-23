//
//  TextAlignment+Extension.swift
//  SZTextField
//
//  Created by Harekrishna on 17/02/21.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
extension TextAlignment {
    func getAlignment() -> Alignment {
        self == .leading ? Alignment.leading : self == .trailing ? Alignment.trailing : Alignment.center
    }
}
