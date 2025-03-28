//
//  BS_AppMessagingPage.swift
//  BS-App
//
//  Created by Tom Knight on 22/03/2025.
//

import SwiftUI

struct BS_AppMessagingPage: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                }
                .padding(.horizontal, 40)
                
                Spacer()
                
                // Bottom section with background and buttons
                ZStack {
                    // Background rectangle
                    Rectangle()
                        .fill(Color(red: 54/255, green: 54/255, blue: 54/255))
                        .frame(height: 100)
                        .alignmentGuide(.bottom) { _ in 0 }
                        .edgesIgnoringSafeArea(.bottom)
                    
                    Rectangle()
                        .fill(Color(red: 189/255, green: 80/255, blue: 255/255))
                        .frame(height: 2)
                        .padding(.bottom, 100)
                    
                    // Bottom buttons with separators
                    HStack(spacing: 4) {
                        MessagingPageBottomButton(imageName: "MainPageIconDeactivated")
                        Divider()
                        MessagingPageBottomButton(imageName: "MapPageIconDeactivated")
                        Divider()
                            .frame(width: 15)
                        MessagingPageBottomButton(imageName: "CameraPageIconDeactivated")
                        Divider()
                            .frame(width: 15)
                        MessagingPageBottomButton(imageName: "MessagingPageIconActivated")
                        Divider()
                        MessagingPageBottomButton(imageName: "SettingsPageIconDeactivated")
                    }
                    .frame(height: 50)
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 36/255, green: 36/255, blue: 36/255))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MessagingPageBottomButton: View {
    let imageName: String
    
    var body: some View {
        Button(action: {
            // Handle button action
        }) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 75)
                .padding(.horizontal, 4)
        }
    }
}

struct BS_AppMessagingPage_Previews: PreviewProvider {
    static var previews: some View {
        BS_AppMessagingPage()
    }
}
