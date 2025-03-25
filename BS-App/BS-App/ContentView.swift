//
//  ContentView.swift
//  BS-App
//
//  Created by Tom Knight on 18/03/2025.
//


import SwiftUI


struct ContentView: View {
    @State private var isLoading = true

    var body: some View {
        if isLoading == true{
            BS_AppLoadingScreen()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        isLoading = false
                    }
                }
        } else {
            TabView {
                BS_AppMainPage()
                    .tabItem { }
                
                BS_AppMapPage()
                    .tabItem { }
                
                BS_AppCameraPage()
                    .tabItem { }
                    .offset(y: 132)
                
                BS_AppMessagingPage()
                    .tabItem { }
                
                BS_AppSettingsPage()
                    .tabItem { }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
