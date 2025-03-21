//
//  BS_AppMainPage.swift
//  BS-App
//
//  Created by Tom Knight on 20/03/2025.
//
import SwiftUI
import SwiftData

struct BS_AppMainPage: View {
    var body: some View {
        NavigationView {
            VStack {
                
                VStack(spacing: 20) {
                    
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                // Bottom buttons with separators
                HStack {
                    BottomButton(imageName: "MainPageIconActivated")
                    
                    Divider()
                        .frame(height: 50)
                        .frame(width: 1)
                    
                    
                    BottomButton(imageName: "MapPageIconDeactivated")
                    
                    Divider()
                        .frame(height: 50)
                        .frame(width: 1)
                    
                    
                    BottomButton(imageName: "CameraPageIconDeactivated")
                    
                    Divider()
                        .frame(height: 50)
                        .frame(width: 1)
                    
                    
                    BottomButton(imageName: "MessagingPageIconDeactivated")
                    
                    Divider()
                        .frame(height: 50)
                        .frame(width: 1)
                    
                    
                    BottomButton(imageName: "SettingsPageIconDeactivated")
                }
                .frame(height: 50)
                .padding(.bottom, 20)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 54/255, green: 54/255, blue: 54/255))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    struct NavigationButton<Destination: View>: View {
        let title: String
        let destination: Destination
        
        var body: some View {
            NavigationLink(destination: destination) {
                Text(title)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 204/255, green: 255/255, blue: 102/255))
                    .cornerRadius(10)
            }
        }
    }
    
    struct BottomButton: View {
        let imageName: String
        
        var body: some View {
            Button(action: {
                // Handle button action
            }) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(.horizontal, 6.5)
            }
        }
    }
    
    struct BS_AppMainPage_Previews: PreviewProvider {
        static var previews: some View {
            BS_AppMainPage()
        }
    }
}
