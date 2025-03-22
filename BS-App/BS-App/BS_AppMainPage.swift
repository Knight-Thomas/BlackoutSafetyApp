//
//  BS_AppMainPage.swift
//  BS-App
//
//  Created by Tom Knight on 21/03/2025.
//
import SwiftUI

struct BS_AppMainPage: View {
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
                        .alignmentGuide(.bottom) { _ in 0 } // Keeps it at the bottom
                        .edgesIgnoringSafeArea(.bottom)
                    
                    Rectangle()
                        .fill(Color(red: 189/255, green: 80/255, blue: 255/255))
                        .frame(height:2)
                        .padding(.bottom, 100)

                    // Bottom buttons with separators
                    HStack(spacing: 4) { // Adjusted spacing
                        MainPageBottomButton(imageName: "MainPageIconActivated")
                        Divider()
                        MainPageBottomButton(imageName: "MapPageIconDeactivated")
                        Divider()
                            .frame(width:15)
                        MainPageBottomButton(imageName: "CameraPageIconDeactivated")
                        Divider()
                            .frame(width:15)
                        MainPageBottomButton(imageName: "MessagingPageIconDeactivated")
                        Divider()
                        MainPageBottomButton(imageName: "SettingsPageIconDeactivated")
                    }
                    .frame(height: 50)
                    .padding(.bottom, 20) // Ensures it sits correctly within the ZStack
                }
                .frame(maxWidth: .infinity) // Prevents stretching beyond needed space
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 36/255, green: 36/255, blue: 36/255))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct MainPageBottomButton: View {
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

struct BS_AppMainPage_Previews: PreviewProvider {
    static var previews: some View {
        BS_AppMainPage()
    }
}
