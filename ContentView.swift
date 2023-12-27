
/*import SwiftUI

struct ContentView: View {
    @ObservedObject var itemsManager : ItemsManager
    var body: some View {
        //DarkMode()
        
        VStack{
            HomeView(itemsManager: itemsManager)
        }
    }
}
*/



import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var navManager : NavigationManager
    @State var presentSideMenu = false
    var body: some View {
        ZStack {
            VStack {
            switch(navManager.selectedItem){
            case 0 : HomeView(navManager: navManager) 
            case 1 : ProfileView(navManager: navManager)
                case 2 : DetailsScreen()
                case 3 : DarkMode()
                case 4 : Text("Vista payment")
                case 5 : Text("Vista settings")
                case 6 : Text("Vista sign up")
                default : Text("Sin contenido")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            /*.overlay(
                ZStack {
                    Color("Bg").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    HStack{
                        Button {
                            presentSideMenu.toggle()
                        } label: {
                            Image("menu")
                                .padding()
                                .background(Color(.white))
                                .cornerRadius(10)
                        }
                        .frame(width: 24, height: 24)
                        .padding(.leading, 30)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.white)
                    .zIndex(1)
                    .shadow(radius: 0.3)
                , alignment: .top
            )//overlay
            */
        
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



