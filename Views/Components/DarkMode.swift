//
//  HomeView.swift
//  E-commerce
//
//  Created by Erick Gámez Sánchez on 06/11/23.
//

import SwiftUI

struct DarkMode: View {
    @AppStorage("isDarkMode") var isDarkMode : Bool = false
    @State private var showingSettingsView: Bool = false
    //@Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Button(action: {
                        isDarkMode.toggle()
                    }, label: {
                        Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                            .imageScale(.large)
                    })
                    .padding()
                }
                
                VStack(spacing: 20){
                    Text("Primary color")
                        .foregroundColor(.primary)
                    Text("Secundary color")
                        .foregroundColor(.secondary)
                    Text("Color white")
                        .foregroundColor(.white)
                    Text("Color black")
                        .foregroundColor(.black)
                    Text("Color globaly adaptive")
                        .foregroundColor(Color("AdaptiveColor"))
                    Text("Color locally adaptive").foregroundColor(isDarkMode ? .yellow : .green)
                }
            }
            .navigationTitle("Dark Mode")
        }
        
    }
    
    struct DarkMode_Preview: PreviewProvider{
        static var previews: some View{
            Group{
                DarkMode()
                    //.preferredColorScheme(isDarkMode ? .dark : .light)
                    
            }
        }
    }
}


