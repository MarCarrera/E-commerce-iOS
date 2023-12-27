//
//  HomeView.swift
//  E-commerce
//
//  Created by Erick Gámez Sánchez on 06/11/23.
//

import SwiftUI
import CodeScanner
import WebKit
import AVFoundation

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var navManager : NavigationManager
    @State var presentSideMenu = false
    // @State private var selectedIndex : Int = 0
    private let categories = ["All", "Chair", "Sofa", "Lamp", "Kitchen", "Table"]
    //scanner
    @State var isPresentingScanner = false
    @State var scannedCode : String?
    //cargar imagenes de galeria
    
    
    var scannerSheet : some View{
        CodeScannerView(
            codeTypes: [.qr],
            completion: {result in
                switch result {
                case .success(let code):
                    self.scannedCode = code.string
                    self.isPresentingScanner = false
                case .failure(let error):
                    print("Error escaneando código QR: \(error.localizedDescription)")
                }
            }
        )
    }
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("DarkGray").edgesIgnoringSafeArea(.all)
                ScrollView{
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
                                
                                SearchAndScanView()
                            }
                            
                            VStack{}.padding(.top, 10)
                
                            
                            TagLineView().padding(.leading, 100)
                            
                            
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack{
                                    ForEach(0 ..< categories.count){i in
                                        //si i == 1 entonces isActive es true
                                        CategoryView(isActive: i == navManager.selectedCategory, text: categories[i])
                                            .onTapGesture {
                                                navManager.selectedCategory = i
                                                print("Categoria seleccionada::::")
                                                print(navManager.selectedCategory)
                                            }
                                    }
                                }
                                .padding()
                            }
                            switch(navManager.selectedCategory){
                            case 0: PopularProducts(presentationMode: presentationMode)
                            case 1: BestProducts()
                            case 2: UploadImages(size: 320)
                            case 3: Text("View New")
                            case 4: Text("View New")
                            case 5: Text("View New")
                            default: PopularProducts(presentationMode: presentationMode)
                                    .padding()
                            }
                            
                            
                        }
                    }
                }
                .background(Color("DarkGray"))
                /*HStack{
                    ButtonNavbar(image: Image("Home")){}
                    ButtonNavbar(image: Image("User")){}
                    ButtonNavbar(image: Image("Home")){}
                    ButtonNavbar(image: Image("User")){}
                }
                .padding()
                .background(Color.white)
                .clipShape(Capsule())
                .padding()
                .frame(maxHeight: .infinity, alignment: .bottom)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 2, y: 6)*/
                
                ShowSideMenu()
            }
        }
    }
    @ViewBuilder
    private func ShowSideMenu() -> some View {
        SideMenu(isShowing: $presentSideMenu, direction: .leading) {
            SideMenuContents(navManager: navManager, presentSideMenu: $presentSideMenu)
                .frame(width: 300)
        }
    }
    struct TagLineView : View{
        var body : some View{
            Text("!Welcome to back¡")
                .font(.system(size: 30))
                .foregroundStyle(Color("Yellow"))
                .frame(alignment: .center)
        }
    }
    struct SearchAndScanView : View{
        @State private var search : String = ""
        @State var isPresentingScanner = false
        @State var scannedCode : String?
        var scannerSheet : some View{
            CodeScannerView(
                codeTypes: [.qr],
                completion: {result in
                    switch result {
                    case .success(let code):
                        self.scannedCode = code.string
                        self.isPresentingScanner = false
                    case .failure(let error):
                        print("Error escaneando código QR: \(error.localizedDescription)")
                    }
                }
            )
        }
        
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
                
                NavigationLink(
                    destination: ScannerView(), label: {
                        Image(systemName: "qrcode.viewfinder")
                            .padding(.all, 4)
                            .font(.system(size: 34))
                            .foregroundColor(.white)
                            .background(Color("Yellow"))
                            .cornerRadius(10)
                        /*.onTapGesture {
                         isPresentingScanner = true
                         }
                         .sheet(isPresented: $isPresentingScanner){
                         self.scannerSheet
                         
                         }*/
                    }
                )
            }
            .padding(.horizontal)
            .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 8)
        }
    }
    struct WebView : UIViewRepresentable{
        let urlString: String
        
        func makeUIView(context: Context) -> WKWebView {
            let webView = WKWebView()
            return webView
        }
        
        func updateUIView(_ uiView: WKWebView, context: Context) {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                uiView.load(request)
            }
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
                    .foregroundColor(isActive ? Color("Yellow") : Color.white.opacity(0.5))
                
                if (isActive) {
                    Color("Yellow")
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
                .foregroundColor(Color("Yellow"))
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
                .foregroundColor(Color("Yellow"))
            
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
    struct UploadImages : View{
        let size : CGFloat
        @State private var selectedImage : UIImage?
        @State private var isimagePickerPresented = false
        @State private var isimagePickerCamera = false
        @State private var imageGalleyIdentifier: String?
        @State private var imageCameraIdentifier: String?
        
        
        var body : some View{
            VStack{
                Text("Upload images")
                    .font(.system(size: 24))
                    .padding(.horizontal)
                    .padding(.top)
                    .foregroundColor(Color("Yellow"))
                
                HStack{
                    HStack{
                        Image(systemName: "photo.fill.on.rectangle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .padding(.leading, 70)
                    .padding(.trailing, 70)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        isimagePickerPresented.toggle()
                    }
                    .sheet(isPresented: $isimagePickerPresented){
                        ImagePickerGallery(image: $selectedImage,
                                    isimagePickerPresented: $isimagePickerPresented, imageIdentifier: $imageGalleyIdentifier
                        )
                    }
                    
                    HStack{
                        Image(systemName: "camera.on.rectangle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .padding(.leading, 70)
                    .padding(.trailing, 70)
                    .foregroundColor(Color.white)
                    .onTapGesture {
                        isimagePickerCamera.toggle()
                    }
                    .sheet(isPresented: $isimagePickerCamera){
                        ImagePickerCamera(image: $selectedImage,
                                          isimagePickerPresented: $isimagePickerPresented, imageCameraIdentifier: $imageCameraIdentifier)
                        
                    }
                }
                
                if let image = selectedImage{
                    VStack{
                        VStack{
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: size, height: 200 * (size/190))
                                .cornerRadius(15)
                            
                            if let pathimageGallery = imageGalleyIdentifier {
                                //path o identificador de ruta de imagen desde galeria
                               // Text("Image Identifier gallery: \(pathimageGallery)")
                            }
                            if let pathImageCamera = imageCameraIdentifier {
                                //path o identificador de ruta de imagen desde camara
                                Text("Image Identifier camera: \(pathImageCamera)")
                            }
                                                
                        }
                        .frame(width: size)
                        .padding(.all, 4)
                        .background(Color.white)
                        .cornerRadius(15)
                        .shadow(color: Color.black.opacity(0.4), radius: 7, x: 0, y: 8)
                        
                        
                    
                    }
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                    
                    PrimaryButton(title: "Send image", image: "paperplane.circle")
                    
                }
                
            }
            

                
            
            
            /*ScrollView(.horizontal, showsIndicators: false){
             HStack{
             ForEach(0 ..< 4){index in
             ProductCard(image: Image("chair_\(index + 1)"), size: 170)
             }
             .padding(.trailing)
             }
             .padding(.leading)
             .padding(.bottom, 20)
             
             }*/
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
    struct PrimaryButton: View {
        var title: String
        var image : String
        var body: some View {
            HStack{
                Text(title)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Image(systemName: image)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color(.white))
                    
            }
            .padding()
            .background(Color("Green"))
            .cornerRadius(38)
            .frame(width: 320)
            .onTapGesture {
                print("Boton enviar imagen")
            }
        }
    }
    
    struct ImagePickerGallery : UIViewControllerRepresentable{
        @Binding var image : UIImage?
        @Binding var isimagePickerPresented : Bool
        @Binding var imageIdentifier: String?
        
        func makeCoordinator() -> ImagePickerCoordinator {
            return ImagePickerCoordinator(image: $image, isImagePickerPresented: $isimagePickerPresented, imageIdentifier: $imageIdentifier)
        }
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            return picker
        }
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
            //code
        }
    }
    struct ImagePickerCamera : UIViewControllerRepresentable{
        @Binding var image : UIImage?
        @Binding var isimagePickerPresented : Bool
        @Binding var imageCameraIdentifier: String?
        
        func makeCoordinator() -> ImagePickerCoordinator {
            return ImagePickerCoordinator(image: $image, isImagePickerPresented: $isimagePickerPresented, imageIdentifier: $imageCameraIdentifier)
        }
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = .camera //utilizamos camara des dispositivo
            return picker
        }
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
            //code
        }
    }
    
    
}


