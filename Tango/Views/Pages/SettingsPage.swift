//
//  SettingsPage.swift
//  Tango
//
//  Created by Глеб Бурштейн on 19.04.2021.
//

import SwiftUI

struct SettingsPage: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @EnvironmentObject var profileVM: ProfileViewModel
    
    @State var username = "username"
    
    
    var body: some View {
        NavigationView {
            VStack {
                Section(header: Text("Profile").font(.custom("Dosis-Bold", size: 20))) {
                    NavigationLink(destination: ChangeableField(imageName: "mail.stack", field: "Email", description: "You will get a confirmation message on your new email.", text: $username)) {
                        SettingsCell(imageName: "mail.stack", title: "Change Email")
                    }
                    
                    NavigationLink(destination: ChangeableField(imageName: "person", field: "Username", description: "You can change your username. Your username should be at least 3 length.", text: $username)) {
                        SettingsCell(imageName: "person", title: "Change Username")
                    }
                    
                    NavigationLink(destination: Text("Destination")) {
                        SettingsCell(imageName: "pencil", title: "Change Password")
                    }
                }
                .padding()
                
                Section(header: Text("Subscription").font(.custom("Dosis-Bold", size: 20))) {
                    
                    NavigationLink(
                        destination: Text("Destination"),
                        label: {
                            SettingsCell(imageName: "wallet.pass.fill", title: "Subscription")
                        })
                }
                .padding()
                
                Section(header: Text("Themes").font(.custom("Dosis-Bold", size: 20))) {
                    Picker("Mode", selection: $isDarkMode) {
                        Image(systemName: "sun.min")
                            .tag(false)
                        Image(systemName: "moon.fill")
                            .tag(true)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .padding()
                
                Spacer()
                
            }
            .foregroundColor(isDarkMode ? Color.AccentColorLight : Color.AccentColorDark)
            .background(isDarkMode ? Color.backgroundColorDark : Color.backgroundColorLight)
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
        .accentColor(isDarkMode ? Color.AccentColorLight : Color.AccentColorDark)
    }
}

struct SettingsCell: View {
    var imageName: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .padding(.trailing, 5)
            
            Text(title)
                .font(.custom("Dosis-Regular", size: 20))
            
            Spacer()
            
            Image(systemName: "chevron.right")
        }
    }
}

struct ChangeableField: View {
    @Environment(\.colorScheme) var colorScheme
    
    var imageName: String
    var field: String
    var description: String
    @Binding var text: String
    
    var body: some View {
        VStack {
            TextBar(text: $text, placeholder: field, imageName: imageName, isSecureField: false)
                .padding(.top, 100)
            Text(description)
                .opacity(0.6)
                .padding()
            
            AccentButton(title: "Save", width: 100, height: 60) {
                
            }
            .foregroundColor(colorScheme == .dark ? .AccentLight : .AccentDark)
            Spacer()
        }
        .accentColor(colorScheme == .dark ? .AccentColorLight : .AccentColorDark)
        .foregroundColor(colorScheme == .dark ? .AccentColorLight : .AccentColorDark)
        .background(colorScheme == .dark ? Color.backgroundColorDark : Color.backgroundColorLight)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
            .preferredColorScheme(.dark)
    }
}

