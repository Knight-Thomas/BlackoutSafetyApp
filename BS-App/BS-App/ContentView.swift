//
//  ContentView.swift
//  BS-App
//
//  Created by Tom Knight on 18/03/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View{
        NavigationView {
            ZStack {
                Color(red:54/255, green:54/255, blue:54/255)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack{
                        Image("AppIconDarkMode")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300)
                            .padding(.bottom , 65)
                    }
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
