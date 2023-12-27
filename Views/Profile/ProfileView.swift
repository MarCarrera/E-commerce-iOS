//
//  HomeView.swift
//  E-commerce
//
//  Created by Erick Gámez Sánchez on 06/11/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var navManager : NavigationManager
    @State var presentSideMenu = false
    @State private var selectedIndex : Int = 0
    private let categories = ["All", "Chair", "Sofa", "Lamp", "Kitchen", "Table", "All", "Chair", "Sofa"]
    var body: some View {
        NavigationStack{
                ZStack{
                    Color("DarkGray").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
         
                        VStack{
                            VStack(alignment: .leading){
                                VStack{}.padding(.top, 10)
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
                                    .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 8)
                                    
                                    Spacer()
                                }
                              //  ScrollView{
                                    VStack{
                                        VStack{
                                            Image("Profile")
                                                .resizable()
                                                .clipShape(Circle())
                                                .frame(width: 120, height: 120)
                                                .overlay(Circle().stroke(Color.orange, lineWidth: 4))
                                                .scaledToFit()
                                                .padding(.top, -40)
                                                .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 8)
                                            VStack{
                                                Text("Abida Sultana")
                                                    .font(.system(size: 30))
                                                    .foregroundColor(Color("PrimaryColor"))
                                            }
                                        }
                                        .foregroundColor(.white)
                                        .padding(.top, 60)
                                        Spacer()
                                        InfoProfile()
                                            .offset(y: 40)
                                            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
                                    }
                            }
                        }
                 
                    HStack{
                        VStack{
                            HStack{
                                Image("star")
                                Text("4.8")
                                    
                            }
                            Text("Rating")
                                .fontWeight(.semibold)
                        }.padding(.trailing, 10)
                        
                        VStack{
                            Text("34")
                                
                            Text("Orders")
                                .fontWeight(.semibold)
                                .padding(.trailing, 10)

                        }
                        VStack{
                            Text("34")
                                
                            Text("Followers")
                                .fontWeight(.semibold)
                                .padding(.trailing, 10)

                        }
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.top, -150)
                    .frame(width: 340)
                    .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)
                    
                    ShowSideMenu()
                }
                /*.edgesIgnoringSafeArea(.bottom)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                                        CustomBarButtonView(action: {presentationMode.wrappedValue.dismiss()}
                                                           ), trailing: CustomBarButtonMenuView()
                )*/
        }
    }
    @ViewBuilder
    private func ShowSideMenu() -> some View {
        SideMenu(isShowing: $presentSideMenu, direction: .leading) {
            SideMenuContents(navManager: navManager, presentSideMenu: $presentSideMenu)
                .frame(width: 300)
        }
    }
    struct InfoProfile : View{
        @State private var nameUser : String = ""
        @State private var phoneUser : String = ""
        @State private var emailUser : String = ""
        @State private var addressUser : String = ""
        var body : some View{
            ZStack{
                VStack(alignment: .leading){
                    VStack(){
                        VStack{
                            //INFORMACION DE USUARIO
                            VStack(spacing: 10){
                                HStack{
                                    Image(systemName: "person.fill").padding(.horizontal)
                                    TextField("Nombre ", text: $nameUser)
                                }
                                Divider()
                                VStack{}.padding(20)
                                
                                HStack{
                                    Image(systemName: "phone.fill").padding(.horizontal)
                                    TextField("Teléfono ", text: $phoneUser)
                                }
                                Divider()
                                VStack{}.padding(20)
                                
                                HStack{
                                    Image(systemName: "envelope.fill").padding(.horizontal)
                                    TextField("Email ", text: $emailUser)
                                }
                                Divider()
                                VStack{}.padding(20)
                                
                                HStack{
                                    Image(systemName: "house.fill").padding(.horizontal)
                                    TextField("Dirección ", text: $addressUser)
                                }
                                Divider()
                                VStack{}.padding(20)
                                
                                HStack{
                                    Image(systemName: "house.fill").padding(.horizontal)
                                    TextField("Dirección ", text: $addressUser)
                                }
                                Divider()
                                VStack{}.padding(20)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                    }
                    .padding(.vertical)
                    
                    
                }
                .padding()
                .padding(.top)
                .background(Color.white)
                .cornerRadius(40)
                
                
            }
        }
    }
    struct TagLineView : View{
        var body : some View{
            Text("Find the best")
                .font(.system(size: 24))
                .foregroundStyle(Color("PrimaryColor"))
            Text("Forniture...")
                .font(.system(size: 30))
                .foregroundStyle(Color("PrimaryColor"))
        }
    }
    struct SearchAndScanView : View{
        @State private var search : String = ""
        var body : some View{
            HStack{
                HStack{
                    Image("Search")
                        .padding(.trailing, 0)
                    TextField("Search furniture", text: $search)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Button(action: {}){
                    Image(systemName: "qrcode.viewfinder")
                        .padding(.all, 4)
                        .font(.system(size: 34))
                        .foregroundColor(.white)
                        .background(Color("PrimaryColor"))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 8)
        }
    }
    struct CategoryView : View{
        let isActive : Bool
        let text: String
        var body : some View{
            VStack(alignment: .leading, spacing: 0){
                Text(text)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(isActive ? Color("PrimaryColor") : Color.black.opacity(0.5))
                
                if (isActive) {
                    Color("PrimaryColor")
                        .frame(width: 30, height: 2)
                        .clipShape(Capsule())
                }
            }
            .padding(.trailing)
        }
    }
    struct ProductCard : View{
        let image : Image
        let size : CGFloat
        var body : some View {
            VStack{
                image
                    .resizable()
                    .frame(width: size, height: 200 * (size/210))
                    .cornerRadius(20)
                Text("Luxury Swedian Chair")
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                HStack(spacing: 2){
                    ForEach(0 ..< 5){ item in
                        Image("star")
                    }
                    Spacer()
                    
                    Text("1299")
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }
            .frame(width: size)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 8)
        }
    }
    struct PopularProducts : View{
        var presentationMode: Binding<PresentationMode>
        var body : some View{
            Text("Popular")
                .font(.system(size: 24))
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0 ..< 4){index in
                        NavigationLink(
                            destination: DetailsScreen(),
                            label: {
                                ProductCard(image: Image("chair_\(index + 1)"), size: 220)
                            })
                        .foregroundColor(.black)
                        .navigationBarBackButtonHidden(true)
                        .onTapGesture {
                            print("Categoria seleccionada::::")
                            print(index)
                        }
                        
                    }
                    .padding(.trailing)
                    
                }
                .padding(.leading)
                .padding(.bottom, 20)
                
            }
        }
    }
    struct BestProducts : View{
        var body : some View{
            Text("Best")
                .font(.system(size: 24))
                .padding(.horizontal)
                .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(0 ..< 4){index in
                        ProductCard(image: Image("chair_\(index + 1)"), size: 170)
                    }
                    .padding(.trailing)
                }
                .padding(.leading)
                .padding(.bottom, 20)
                
            }
        }
    }
    struct ButtonNavbar : View{
        let image : Image
        let action: ()-> Void
        var body : some View{
            Button(action: action, label:{
                image
                    .frame(maxWidth: .infinity)
            })
        }
    }
    struct FollowersNavbar : View{
        let image : Image
        let action: ()-> Void
        var body : some View{
            Button(action: action, label:{
                image
                    .frame(maxWidth: .infinity)
            })
        }
    }
    struct CustomBarButtonView : View{
        let action: () -> Void
        var body: some View{
            Button(action: action, label:{
                Image(systemName: "chevron.backward")
                .padding(.all, 12)
                .foregroundColor(.black)
                .background(Color.white)
                .cornerRadius(8)
            })
        }
    }
}





