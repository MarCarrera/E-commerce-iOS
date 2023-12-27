

import SwiftUI

struct ContentViewExample: View {
    @ObservedObject var navManager : NavigationManager
    @State var presentSideMenu = false
    
    var body: some View {
        
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                switch(navManager.selectedItem){
                    
                case 0 : HomeView(navManager: navManager)
                case 1 : Text("Vista profile")
                case 2 : Text("Vista account")
                case 3 : Text("Vista buys")
                case 4 : Text("Vista payment")
                case 5 : Text("Vista settings")
                case 6 : Text("Vista sign up")
                default : Text("Sin contenido")
                    
                }
                
               /* if itemsManager.selectedItem == 0 {Text("Vista home")}else{
                    Text("Contenido")
                }*/
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            .overlay(
                ZStack {
                    HStack {
                        Button {
                            presentSideMenu.toggle()
                        } label: {
                            Image("menu")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 24, height: 24)
                        .padding(.leading, 30)
                        
                        Spacer()
                    }
                }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .zIndex(1)
                    .shadow(radius: 0.3)
                , alignment: .top
            )//overlay
            .background(Color.gray.opacity(0.8))
            
            ShowSideMenu()
        }
        
        .frame(maxWidth: .infinity)
        
    }
    
    
    @ViewBuilder
    private func ShowSideMenu() -> some View {
        
        SideMenu(isShowing: $presentSideMenu, direction: .leading) {
            SideMenuContents(navManager: navManager, presentSideMenu: $presentSideMenu)
                .frame(width: 300)
        }
    }
    
}

