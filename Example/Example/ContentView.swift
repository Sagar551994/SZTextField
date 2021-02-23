//
//  ContentView.swift
//  Example
//
//  Created by Harekrishna on 23/02/21.
//

import SwiftUI
import SZTextField

struct ContentView: View {
    
    @State private var fname: String = ""
    @State private var lname: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color.black
            VStack(spacing: 80) {
                Spacer()
                VStack {
                    Text("Mr.")
                        .font(.title)
                        .foregroundColor(Color.white.opacity(0.8))
                    Text("iOS Developer")
                        .font(.largeTitle)
                        .foregroundColor(Color.white.opacity(0.8))
                    Text("@sagar_zalavadiya")
                        .font(.headline)
                        .foregroundColor(Color.white.opacity(0.8))
                }
                VStack(spacing: 60) {
                    HStack(spacing: 30) {
                        SZTextField($fname, placeholder: "First Name", editingChanged: { (isChanged) in
                            
                        }) {
                            
                        }
                        .accentColor(.white)
                        .keyboardType(.emailAddress)
                        .modifier(ThemeTextField())
                        
                        SZTextField($lname, placeholder: "Last Name", editingChanged: { (isChanged) in
                            
                        }) {
                            
                        }
                        .accentColor(.white)
                        .keyboardType(.emailAddress)
                        .modifier(ThemeTextField())
                    }
                    SZTextField($email, placeholder: "Email", editingChanged: { (isChanged) in
                        
                    }) {
                        
                    }
                    .addImageView(true, isimageright: false, image: Image(systemName: "paperplane.fill"), imagesize: CGSize(width: 15, height: 15), imagetintcolor: .gray)
                    .accentColor(.white)
                    .keyboardType(.emailAddress)
                    .modifier(ThemeTextField())
                    
                    SZTextField($phone, placeholder: "Mobile No", editingChanged: { (isChanged) in
                        
                    }) {
                        
                    }
                    .addImageView(true, isimageright: false, image: Image(systemName: "phone.fill"), imagesize: CGSize(width: 15, height: 15), imagetintcolor: .gray)
                    .accentColor(.white)
                    .keyboardType(.emailAddress)
                    .modifier(ThemeTextField())
                    
                    SZTextField($password, placeholder: "Password", editingChanged: { (isChanged) in
                        
                    }) {
                        
                    }
                    .addImageView(true, isimageright: true, image: Image(systemName: "eye"), imagesize: CGSize(width: 20, height: 15), imagetintcolor: .gray)
                    .isSecureTextEntry(true)
                    .accentColor(.white)
                    .modifier(ThemeTextField())
                    
                }
                
                Button(action: {
                    print("Login Tapping")
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundColor(Color.white.opacity(0.8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                .stroke(
                                    LinearGradient(gradient: Gradient(colors: [
                                        Color.white.opacity(0.8),
                                        Color.white.opacity(0.4),
                                        Color.white.opacity(0.1)
                                    ]), startPoint: .topLeading, endPoint: .bottomLeading)
                                )
                            )
                            .shadow(color: Color.white.opacity(0.4), radius: 20, x: 0.0, y: 30.0)
                        Text("Signin")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    
                })
                .frame(width: UIScreen.main.bounds.width - 40, height: 60, alignment: .center)
                
                Spacer(minLength: 60)
            }
            .padding(.horizontal)
        }.edgesIgnoringSafeArea(.all)
        
    }
}

//MARK: ViewModifier
struct ThemeTextField: ViewModifier {
    func body(content: Content) -> some View {
        content.frame(height: 50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
