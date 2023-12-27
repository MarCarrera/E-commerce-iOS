//
//  SideviewContents.swift
//  E-commerce
//
//  Created by Erick Gámez Sánchez on 11/11/23.
//

import SwiftUI

struct SideMenuContents: View {
    @ObservedObject var navManager : NavigationManager
    @Binding var presentSideMenu: Bool
    //@State var selectedItem : Int = 0
    @State var yOffset : CGFloat = 0
    
    var body: some View {
        ZStack{
            Color("Yellow")
                .frame(width: 266)
                .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
            VStack{
                UserIamge()
                TabView(selectedItem: $navManager.selectedItem, yOffset: $yOffset)
                Divider()
                    .padding(.top, -320)
                SliderView()
                    .padding(.top, -290)
                HStack{
                    Text("Learn more about this app")
                        .padding(.leading)
                    Image(systemName: "questionmark.circle")
                }
                .foregroundColor(.white)
                .padding(.top, -110)
                .padding(.trailing)
                
                HStack{
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack(spacing: 12){
                            Image(systemName: "circle.lefthalf.filled")
                                .foregroundColor(.white)
                                .font(.system(size: 40))
                            Text("Dark Mode")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .foregroundColor( Color(.white) )
                        }
                    })
                }
                .padding(.top, -80)
            }
        }
        .ignoresSafeArea()
        .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
        
    }
    struct UserIamge : View{
        var body : some View{
            HStack{
                Circle()
                    .frame(width: 65, height: 65)
                    .foregroundColor(.white)
                VStack{
                    RoundedRectangle(cornerRadius: 3, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .frame(width: 100, height: 14)
                    RoundedRectangle(cornerRadius: 3, style: .continuous)
                        .frame(width: 80, height: 7)
                        .opacity(0.5)
                    RoundedRectangle(cornerRadius: 3, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                        .frame(width: 52, height: 7)
                        .opacity(0.5)
                }
            }
            .foregroundColor(.white)
            .padding(.top, 60)
            Spacer()
        }
    }
    struct TabView : View{
        @Binding var selectedItem : Int
        @Binding var yOffset : CGFloat
        @State var isAnimation = false
        private let categories = ["Home", "Profile", "Account", "Buys", "Payment", "Settings", "Sign Up"]
        private let iconCategory = ["house.circle.fill","person.crop.circle.fill", "dollarsign.circle.fill", "cart.circle.fill", "creditcard.circle.fill","gearshape.fill","arrowshape.turn.up.backward.circle.fill"]
        
        var body: some View{
            ZStack(alignment: .leading){
                VStack(spacing: 20){
                    ForEach(0 ..< categories.count){i in
                        //si i == 1 entonces isActive es true
                        CategoryTab(isActive: i == selectedItem, text: categories[i], icon: iconCategory[i])
                            .onTapGesture {
                                selectedItem = i
                                print("Item seleccionado:::::")
                                print(selectedItem)
                            }
                    }
                }
                .padding(.top, -560) //-600
                .frame(width: 240, height: 330)
            }
        }
    }
    struct CategoryTab : View{
        let isActive : Bool
        let text: String
        let icon : String
        var body : some View{
            ZStack{
                HStack(spacing: 10){
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .font(.system(size: 36))
                    Text(text)
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundColor( Color(.white) )
                   Spacer()
                }
                .padding(.trailing)
                
                if (isActive) {
                    Color(.white).opacity(0.5)
                        .frame(width: 280, height: 56)
                        .clipShape(Capsule())
                        .offset(x: -35)
                        .padding(.leading, -25)
                        
                }
            }
           .padding(.trailing, -30)
        }
    }
    struct Divider: View{
        var body : some View{
            Rectangle().frame(width: 266, height: 1)
                .foregroundColor(.black.opacity(0.5))
                .padding(.top, 30)
        }
    }
}


