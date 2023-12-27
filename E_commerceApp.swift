//
//  E_commerceApp.swift
//  E-commerce
//
//  Created by Erick Gámez Sánchez on 06/11/23.
//

import SwiftUI

@main
struct E_commerceApp: App {
    @AppStorage("isDarkMode") var isDarkMode : Bool = false
    let navManager = NavigationManager()
    
    var body: some Scene {
        WindowGroup {
            //ContentView(navManager: navManager).preferredColorScheme(isDarkMode ? .dark : .light)
            MainView()
        }
    }
}
