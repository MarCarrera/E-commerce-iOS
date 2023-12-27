//
//  ScannerView.swift
//  E-commerce
//
//  Created by Erick Gámez Sánchez on 13/11/23.
//

import SwiftUI
import CodeScanner
import WebKit
import AVFoundation

struct ScannerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>//ver barra lateral de navegacion
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
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("DarkGray").edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(spacing: 8){
                    
                    if let scannedCode = scannedCode{
                        WebView(urlString: scannedCode)
                    }else{
                        Button("Scan QR Code"){
                            self.isPresentingScanner = true
                        }
                        .sheet(isPresented: $isPresentingScanner){
                            self.scannerSheet
                        
                        }
                    }
                }
            }
            .padding(.top, 96)
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(false)
            .accentColor(Color.white)
            .background(Color("DarkGray"))
            /*.navigationBarItems(leading:
                                    CustomBarButtonView(action: {presentationMode.wrappedValue.dismiss()}
                                                       ), trailing: CustomBarButtonMenuView()
            )*/
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
}

#Preview {
    ScannerView()
}
