//
//  HomeView.swift
//  login
//
//  Created by Erick Gámez Sánchez on 05/12/23.
//

import SwiftUI
import LocalAuthentication


struct MainView: View {
    @State var canShowApp: Bool = true
    let context = LAContext()
    //intros ...
    @State var intros : [Intro] = [
        Intro(title: "Plan", subTitle: "Your Routes", description: "View your collection route follow, change or add to your route yourself", pic: "Pic1", color: Color("Green")),
        Intro(title: "Quick Waste", subTitle: "Transfer Note", description: "Record oil collections easily and acourately. No more paper!", pic: "Pic2", color: Color("DarkGray")),
        Intro(title: "Invite", subTitle: "Restaurants", description: "Know some restaurant who want to optimize oil collection? Invite them with one click", pic: "Pic3", color: Color("Yellow")),
    ]
    
    //Gesture properties
    @GestureState var isDragging = false
    @State var currentIndex = 0
    @State var fakeIndex = 0
    @State var showHome = false
    @AppStorage("isDarkMode") var isDarkMode : Bool = false
    let navManager = NavigationManager()
    
    var body: some View {
        ZStack{
            ZStack{
                if canShowApp{
                    ForEach(intros.indices.reversed(), id: \.self){index in
                        //intro view
                        IntroView(intro: intros[index])
                        //custom liquid view
                            .clipShape(LiquidShape(offset: intros[index].offset, curvePoint: fakeIndex == index ? 50 : 0))
                            //.padding(.trailing,fakeIndex == index ? 15 : 0)
                            .ignoresSafeArea()
                    }
                    //vista home
                    if showHome{
                        //SignInScreenView()
                        ContentView(navManager: navManager).preferredColorScheme(isDarkMode ? .dark : .light)
                    }
                }
            }
            //arrow with Drag Gesture
            .overlay(
                Button(action: {
                    
                }, label: {
                    if showHome == false{
                        Image(systemName: "chevron.left")
                            .padding(.leading, 26)
                            .padding(.top, -10)
                            .font(.largeTitle)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color("Green"))
                            .contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .updating($isDragging, body: { value, out, _ in out = true})
                                    .onChanged({value in
                                        withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)){
                                            intros[fakeIndex].offset = value.translation
                                        }
                                    })
                                    .onEnded({value in
                                        withAnimation(.spring()){
                                            //checking...
                                            
                                            if -intros[fakeIndex].offset.width > getRect().width / 2{
                                                
                                                intros[fakeIndex].offset.width = -getRect().height * 1.6
                                                
                                                //updating index
                                                fakeIndex += 1
                                                
                                                if fakeIndex == 3{
                                                    //mostrar vista home despues de las intros
                                                    showHome.toggle()
                                                }
                                            }else{
                                                intros[fakeIndex].offset = .zero
                                                
                                            }
                                            
                                            
                                        }
                                        
                                    })
                                
                                )
                    }
                    
                            
                })
                .offset(y: 53)
                .opacity(isDragging ? 0 : 1)
                .animation(.linear, value: isDragging)
                ,alignment: .topTrailing
            )
        }
        
        .onAppear(perform: {
           // authenticate()
        })
        
        
    }
    func authenticate(){
        var error: NSError?
      
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Por favor autentícate para continuar") { success, error in
                        if success {
                            canShowApp.toggle()
                        } else {
                            print("Error en la autenticación biométrica")
                        }
                    }
        }else{
            print("El dispositivo no soporta autenticación Biométrica")
        }
    }
    @ViewBuilder
    func IntroView(intro: Intro) -> some View{
   //     ZStack{intro.color.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack{
                
                Image(intro.pic)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(40)
                
                VStack(alignment: .leading, spacing: 0){
                    Text(intro.title)
                        .font(.system(size: 45))
                    Text(intro.subTitle)
                        .font(.system(size: 50, weight: .bold))
                    Text(intro.description)
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .padding(.top)
                        .lineSpacing(10)
                        .frame(width: getRect().width - 100)
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding([.trailing, .top])
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(
                intro.color
            )
        
            
       // }.ignoresSafeArea()
        
    }
}
struct LiquidShape : Shape{
    var offset : CGSize
    var curvePoint : CGFloat
    var animatableData: AnimatablePair<CGSize.AnimatableData,CGFloat>{
        get{return AnimatablePair(offset.animatableData, curvePoint)}
        set{offset.animatableData = newValue.first
            curvePoint = newValue.second}
    }
    func path(in rect: CGRect) -> Path {
        return Path{ path in
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)
            
            //rectangle shape
            path.move(to: CGPoint(x: 0, y:0))
            path.addLine(to: CGPoint(x: rect.width, y:0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            //curve shape
            let from = 80 + (offset.width)
            path.move(to: CGPoint(x:rect.width, y: from > 80 ? 80 : from))
            
            //adding height
            var to = 180 + (offset.height) + (-offset.width)
                        to = to < 180 ? 180 : to
                        
                        let mid : CGFloat = 80 + ((to - 80) / 2)
                        
                        path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - curvePoint, y: mid), control2: CGPoint(x: width - curvePoint, y: mid))
            
            
        }
    }
}



extension View{
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}

