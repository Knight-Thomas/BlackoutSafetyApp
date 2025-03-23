//
//  ContentView.swift
//  BS-App
//
//  Created by Tom Knight on 18/03/2025.
//

import SwiftUI
import SwiftData


import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BS_AppMainPage()
                .tabItem {
                    
                }
            
            BS_AppMapPage()
                .tabItem {
                    
                }
            
            BS_AppCameraPage()
                .tabItem {
                    
                }
                .onAppear{
                    
                }
                .offset(y:132)
            BS_AppMessagingPage()
                .tabItem {
                    
                }
            BS_AppSettingsPage()
                .tabItem{
                    
                }
        }
        .onAppear{
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
