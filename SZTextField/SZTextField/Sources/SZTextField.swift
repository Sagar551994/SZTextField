//
//  SZTextField.swift
//  SZTextField
//
//  Created by Harekrishna on 16/02/21.
//

import SwiftUI

@available(iOS 13.0, *)
public protocol SZTextFieldStyle {
    func body(content: SZTextField) -> SZTextField
}

public struct SZTextField: View {
    
    // MARK:- variables
    @Binding var textFieldValue: String
    @State fileprivate var isSelected: Bool = false
    @State fileprivate var isShowError: Bool = false
    
    private var editingChanged: (Bool) -> () = { _ in }
    private var commit: () -> () = { }
    
    private var placeholderText: String
    
    //MARK: Observed Object
    @ObservedObject private var notifier = SZTextFieldNotifier()
    
    private var currentError: TextFieldValidator {
        if notifier.isRequiredField && isShowError && textFieldValue.isEmpty {
            return TextFieldValidator(condition: false, errorMessage: notifier.requiredFieldMessage)
        }
        
        if let firstError = notifier.arrValidator.filter({!$0.condition}).first {
            return firstError
        }
        return TextFieldValidator(condition: true, errorMessage: "")
    }
    
    //MARK: Init
    public init(_ text: Binding<String>, placeholder: String = "", editingChanged: @escaping (Bool)->() = { _ in }, commit: @escaping ()->() = { }) {
        self._textFieldValue = text
        self.placeholderText = placeholder
        self.editingChanged = editingChanged
        self.commit = commit
    }
    
    // MARK: Center View
    var centerTextFieldView: some View {
        HStack(spacing: 10) {
            if !notifier.isImageRight && notifier.isImageShow {
                notifier.image
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(notifier.imageTintColor)
                    .frame(width: notifier.imageSize.width, height: notifier.imageSize.height, alignment: .center)
            }
            ZStack(alignment: notifier.sztextAlignment.getAlignment()) {
                ZStack {
                    Rectangle()
                        .frame(height: notifier.sztextFontSize, alignment: .center)
                        .foregroundColor(textFieldValue.isEmpty ? Color.clear : notifier.szplaceholderBGColor)
                        .padding(.horizontal, -10)
                    Text(placeholderText)
                        .font(.custom(notifier.sztextFontString, size: textFieldValue.isEmpty ? notifier.sztextFontSize : notifier.sztextFontSize > 14 ? notifier.sztextFontSize - 5 : notifier.sztextFontSize))
                        .multilineTextAlignment(notifier.sztextAlignment)
                        .foregroundColor(textFieldValue.isEmpty ? notifier.szplaceholderColor : notifier.szselectplaceholderColor)
                    
                }
                .fixedSize()
                .offset(x: notifier.isImageShow ? textFieldValue.isEmpty ? 0.0 : -(notifier.imageSize.width) : textFieldValue.isEmpty ? 0.0 : 0.0, y: textFieldValue.isEmpty ? 0.0 : -(notifier.szselectedLineHeight - notifier.sztextFontSize - 2))
                if notifier.isSecureTextEntry {
                    SecureField("", text: $textFieldValue.animation()) {
                    }
                    .onTapGesture {
                        self.editingChanged(self.isSelected)
                        if !self.isSelected {
                            UIResponder.currentFirstResponder?.resignFirstResponder()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            if let currentResponder = UIResponder.currentFirstResponder, let currentTextField = currentResponder.globalView as? UITextField{
                                arrTextFieldEditActions = self.notifier.arrTextFieldEditActions
                                self.isSelected = self.notifier.isSecureTextEntry
                                currentTextField.addAction(for: .editingDidEnd) {
                                    self.isSelected = false
                                    self.isShowError = self.notifier.isRequiredField
                                    self.commit()
                                }
                            }
                        }
                    }
                    .font(.custom(notifier.sztextFontString, size: notifier.sztextFontSize))
                    .multilineTextAlignment(notifier.sztextAlignment)
                    .foregroundColor(notifier.sztextColor)
                } else {
                    TextField("", text: $textFieldValue.animation(), onEditingChanged: { (isChanged) in
                        withAnimation(Animation.default.speed(0.8), {
                            self.isSelected = isChanged
                            self.editingChanged(isChanged)
                            self.isShowError = self.notifier.isRequiredField
                            arrTextFieldEditActions = self.notifier.arrTextFieldEditActions
                        })
                    }, onCommit: {
                        withAnimation(Animation.default.speed(0.8), {
                            self.isShowError = self.notifier.isRequiredField
                            self.commit()
                        })
                    })
                    .font(.custom(notifier.sztextFontString, size: notifier.sztextFontSize))
                    .multilineTextAlignment(notifier.sztextAlignment)
                    .foregroundColor(notifier.sztextColor)
                }
            }
            if notifier.isImageRight && notifier.isImageShow {
                notifier.image
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(notifier.imageTintColor)
                    .frame(width: notifier.imageSize.width, height: notifier.imageSize.height, alignment: .center)
            }
            
        }
        .padding(.horizontal)
    }

    
    // MARK: Bottom Line View
    var bottomLine: some View {
        RoundedRectangle(cornerRadius: notifier.szcornerRadius)
            .stroke(textFieldValue.isEmpty ? notifier.szlineColor : notifier.szselectedLineColor)
            .frame(height: textFieldValue.isEmpty ? notifier.szlineHeight : notifier.szselectedLineHeight, alignment: .leading)
    }
    
    //MARK: Body View
    public var body: some View {
        VStack () {
            ZStack(alignment: .bottomLeading) {
                bottomLine
                HStack {
                    // Left View
                    notifier.szleftView
                    
                    // Center View
                    centerTextFieldView
                    
                    //Right View
                    notifier.szrightView
                }
                .padding(.bottom, 8)                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottomLeading)
    }
}



//MARK: View Property Funcation
@available(iOS 13.0, *)
extension SZTextField {
    /// Sets the left view.
    public func leftView<LRView: View>(@ViewBuilder _ view: @escaping () -> LRView) -> Self {
        notifier.szleftView = AnyView(view())
        return self
    }
    
    /// Sets the right view.
    public func rightView<LRView: View>(@ViewBuilder _ view: @escaping () -> LRView) -> Self {
        notifier.szrightView = AnyView(view())
        return self
    }
}

//MARK: Text Property Funcation
@available(iOS 13.0, *)
extension SZTextField {
    /// Sets the alignment for text.
    public func textAlignment(_ alignment: TextAlignment) -> Self {
        notifier.sztextAlignment = alignment
        return self
    }
    
    /// Sets the secure text entry for TextField.
    public func isSecureTextEntry(_ isSecure: Bool) -> Self {
        notifier.isSecureTextEntry = isSecure
        return self
    }
}

//MARK: Line or Box Property Funcation
@available(iOS 13.0, *)
extension SZTextField {
    /// Sets the alignment for text.
    public func lineorbox(_ lineHeight: CGFloat, selectlineHeight: CGFloat, lineColor: Color, selectlineColor: Color, radius: CGFloat) -> Self {
        notifier.szlineHeight = lineHeight
        notifier.szselectedLineHeight = selectlineHeight
        notifier.szlineColor = lineColor
        notifier.szselectedLineColor = selectlineColor
        notifier.szcornerRadius = radius
        return self
    }
}


//MARK: Placeholder Property Funcation
@available(iOS 13.0, *)
extension SZTextField {
    /// Sets the placeholder color.
    public func textFieldCustomize(_ sztextFontString: String, sztextFontSize: CGFloat, sztextColor: Color, szplaceholderBGColor: Color, szplaceholderColor: Color, szselectplaceholderColor: Color) -> Self {
        notifier.sztextFontString = sztextFontString
        notifier.sztextFontSize = sztextFontSize
        notifier.sztextColor = sztextColor
        notifier.szplaceholderBGColor = szplaceholderBGColor
        notifier.szplaceholderColor = szplaceholderColor
        notifier.szselectplaceholderColor = szselectplaceholderColor
        return self
    }

}

//MARK: Error Property Funcation
@available(iOS 13.0, *)
extension SZTextField {
    /// Sets the is show error message.
    public func isShowError(_ show: Bool) -> Self {
        notifier.isShowError = show
        return self
    }
    
    /// Sets the validation conditions.
    public func addValidations(_ conditions: [TextFieldValidator]) -> Self {
        notifier.arrValidator.append(contentsOf: conditions)
        return self
    }
    
    /// Sets the validation condition.
    public func addValidation(_ condition: TextFieldValidator) -> Self {
        notifier.arrValidator.append(condition)
        return self
    }
    
    /// Sets the error color.
    public func errorColor(_ color: Color) -> Self {
        notifier.errorColor = color
        return self
    }
    
    /// Sets the field is required or not with message.
    public func isRequiredField(_ required: Bool, with message: String) -> Self {
        notifier.isRequiredField = required
        notifier.requiredFieldMessage = message
        return self
    }
}

//MARK: Text Field Editing Funcation
@available(iOS 13.0, *)
extension SZTextField {
    /// Disable text field editing action. Like cut, copy, past, all etc.
    public func addDisableEditingAction(_ actions: [TextFieldEditActions]) -> Self {
        notifier.arrTextFieldEditActions = actions
        return self
    }
}

@available(iOS 13.0, *)
extension SZTextField {
    public func addImageView(_ isimageshow: Bool, isimageright: Bool, image: Image, imagesize: CGSize, imagetintcolor: Color) -> Self {
        notifier.isImageShow = isimageshow
        notifier.isImageRight = isimageright
        notifier.image = image
        notifier.imageSize = imagesize
        notifier.imageTintColor = imagetintcolor
        return self
    }
}

//MARK: FloatingLabelTextField Style Funcation
@available(iOS 13.0, *)
extension SZTextField {
    public func floatingStyle<S>(_ style: S) -> some View where S: SZTextFieldStyle {
        return style.body(content: self)
    }
}
