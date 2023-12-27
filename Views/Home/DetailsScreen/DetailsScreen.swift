//
//  DetailsScreen.swift
//  E-commerce
//
//  Created by Erick Gámez Sánchez on 10/11/23.
//

import SwiftUI

struct DetailsScreen : View{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body : some View{
        ZStack{
            Color("Bg")
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ScrollView{
                Image("chair_1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                DescripctionView()
                    .offset(y: -40)
            }
            .edgesIgnoringSafeArea(.top)
            
            HStack(){
                Text("$1299")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("Add  to cart")
                        .padding()
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)
                        .foregroundColor(Color("PrimaryColor"))
                })
            }
            .padding()
            .padding(.horizontal)
            .background(Color("PrimaryColor"))
            .cornerRadius(50, corners: .topLeft)
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                CustomBarButtonView(action: {presentationMode.wrappedValue.dismiss()}
                                                   ), trailing: CustomBarButtonMenuView()
        )
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
struct CustomBarButtonMenuView : View{
    var body: some View{
        Image(systemName: "ellipsis")
        .padding(.all, 12)
        //.background(Color.white)
        .foregroundColor(.black)
        .cornerRadius(8)
    }
}
struct DescripctionView : View{
    var body : some View{
        VStack(alignment: .leading){
            HStack(alignment: .top){
                Text("Luxury Swedia \nChair")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                HStack(spacing: 2){
                    ForEach(0 ..< 5){ item in
                        Image("star")
                    }
                    Text("(4.9)")
                        .opacity(0.5)
                        .padding(.leading, 8)
                    Spacer()
                }
            }
            Text("Description")
                .fontWeight(.medium)
                .padding(.vertical, 8)
            Text("Luxury Swedian Chair is a contemporary chair based on the virtues of modern craft. It carries on the simplicity and honestly of the archetypical chair.")
                .lineSpacing(8)
                .opacity(0.6)
            HStack(alignment: .top){
                VStack{
                    Text("Size")
                        .fontWeight(.semibold)
                        .padding(.bottom, 4)
                    Text("Height : 120 cm")
                        .opacity(0.6)
                    Text("Wide: 80 cm")
                        .opacity(0.6)
                    Text("Diameter: 72 cm")
                        .opacity(0.6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading){
                    Text("Treatment")
                        .fontWeight(.semibold)
                        .padding(.bottom, 4)
                    
                    Text("Jati Wood Canvas \nAmazing Love")
                        .opacity(0.6)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical)
            
            HStack(alignment: .bottom){
                VStack(alignment: .leading){
                    Text("Colors")
                        .fontWeight(.semibold)
                    
                    HStack{
                        ColorDotView(color: .white)
                        ColorDotView(color: Color("PrimaryColor"))
                        ColorDotView(color: .black)
                        ColorDotView(color: .gray)
                    }
                }
                Spacer()
                
                VStack(alignment: .leading){
                    Text("Quality")
                        .fontWeight(.semibold)
                    
                    HStack{
                        Button(action: {}){
                            Image(systemName: "minus")
                                .padding(.all, 8)
                        }
                        .frame(width: 30, height: 30)
                        .overlay(RoundedRectangle(cornerRadius: 50).stroke())
                        .foregroundColor(.black)
                        
                        Text("1")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 0)
                        
                        Button(action: {}){
                            Image(systemName: "plus")
                                .padding(.all, 8)
                        }
                        .frame(width: 30, height: 30)
                        .background(Color("PrimaryColor"))
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                    }
                }
            }
        }
        .padding()
        .padding(.top)
        .background(Color.white)
        .cornerRadius(40)
    }
}

struct ColorDotView : View{
    let color : Color
    var body : some View{
        color
            .frame(width: 24, height: 24)
            .clipShape(Circle())
    }
}
struct RoundedCorner: Shape {
    var radius : CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path{
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
        cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View{
        clipShape( RoundedCorner(radius: radius, corners: corners))
    }
}

#Preview {
    DetailsScreen()
}
