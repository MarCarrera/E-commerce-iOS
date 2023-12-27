//
//  SliderView.swift
//  E-commerce
//
//  Created by Erick Gámez Sánchez on 10/11/23.
//

import SwiftUI

struct SliderView: View {
    @State var selectedIndex = 0
    let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
    var body: some View {
        TabView(selection: $selectedIndex){
            ImageView(image: "img1").tag(1)
            ImageView(image: "img2").tag(2)
            ImageView(image: "img3").tag(3)
            ImageView(image: "img4").tag(4)
            ImageView(image: "img5").tag(5)
            ImageView(image: "img6").tag(6)
            ImageView(image: "img7").tag(7)
            ImageView(image: "img8").tag(8)
            ImageView(image: "img9").tag(9)
            ImageView(image: "img10").tag(10)
        }
        .tabViewStyle(PageTabViewStyle())
        .offset(x: -10)
        .frame(width: 266, height: 170)
        .padding(.top, 10)
        .onReceive(timer){ _ in
            withAnimation{selectedIndex = selectedIndex == 10 ? 0 : selectedIndex + 1}
        }
    }
    struct ImageView : View{
        var image = ""
        var body : some View{
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 230, height: 157)
                .clipped()
                .cornerRadius(10)
                .padding(.leading, 15)
        }
    }
}

#Preview {
    SliderView()
}
