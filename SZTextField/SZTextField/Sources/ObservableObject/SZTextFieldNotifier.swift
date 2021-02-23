//
//  SZTextFieldNotifier.swift
//  SZTextField
//
//  Created by Harekrishna on 17/02/21.
//

import SwiftUI

@available(iOS 13.0, *)
class SZTextFieldNotifier: ObservableObject {
    
    //MARK: Views Properties
    @Published var szleftView: AnyView?
    @Published var szrightView: AnyView?
    
    //MARK: Alignment Properties
    @Published var sztextAlignment: TextAlignment = .leading
    
    //MARK: Line Properties
    @Published var szlineHeight: CGFloat = 1
    @Published var szselectedLineHeight: CGFloat = 50.0
    @Published var szlineColor: Color = .gray
    @Published var szselectedLineColor: Color = .white
    @Published var szcornerRadius: CGFloat = 10
    
    //MARK: Text Properties
    @Published var sztextFontString: String = "HelveticaNeue-Bold"
    @Published var sztextFontSize: CGFloat = 15.0
    @Published var sztextColor: Color = .white
    @Published var szplaceholderBGColor: Color = .black
    @Published var szplaceholderColor: Color = .gray
    @Published var szselectplaceholderColor: Color = .white
    
    //MARK: Other Properties
    @Published var spaceBetweenTitleText: Double = 15
    @Published var isSecureTextEntry: Bool = false
    
    //MARK: Error Properties
    @Published var isShowError: Bool = false
    @Published var errorColor: Color = .red
    @Published var arrValidator: [TextFieldValidator] = []
    @Published var isRequiredField: Bool = false
    @Published var requiredFieldMessage: String = ""
    
    //MARK: Action Editing Properties
    @Published var arrTextFieldEditActions: [TextFieldEditActions] = []
    
    //MARK: Image on Left or Right Side
    @Published var isImageShow: Bool = false
    @Published var isImageRight: Bool = false
    @Published var image: Image = Image(systemName: "house.fill")
    @Published var imageSize: CGSize = CGSize(width: 15, height: 15)
    @Published var imageTintColor: Color = Color.gray
    
}
