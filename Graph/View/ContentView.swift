//
//  ContentView.swift
//  Graph
//
//  Created by Philippe MICHEL on 09/04/2024.
//

import SwiftUI

struct ContentView: View {
    // changer la taille de la police dans le navigationTitle
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.preferredFont(forTextStyle: .footnote)]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont.preferredFont(forTextStyle: .footnote)]
    }
    private var buttons:[String] = ["Entrées Payantes", "Entrées Gratuites", "Total entrées"]
    private var colors:[Color] = [.red, .green, .purple]
    
    @State private var buttonSelected:String = "Entrées Payantes"
    @State private var textToShow = ""
    @State private var currentIndex = 0
    @State private var showView:Bool = false
    @State private var endOfSentance:Bool = false
    let fullText = "Insérer facilement des graphiques dans vos applications. Dans cet exemple, j'utilise une API de fréquentation des musées."
    
    var connectionmusee:APIConnection = APIConnection()
    
    let buttonWidth:CGFloat = 110
    let buttonHeight:CGFloat = 80
    let buttonCorner:CGFloat = 10
    
    var body: some View {
        NavigationStack{
            VStack {
                Text(textToShow)
                    .font(.headline)
                    .padding()
                    .foregroundColor(.primary)
                    .background(.gray)
                    .cornerRadius(buttonCorner)
                    .shadow(color:.primary, radius: buttonCorner)
                    .frame(width: 350, height: 150)
                Spacer()
                
                if endOfSentance {
                    HStack(spacing: 6){
                        ForEach(0..<3) {index in
                            Button (action: {
                                buttonSelected = buttons[index]
                                self.showView.toggle()
                                
                            }, label: {
                                Text(buttons[index]).tag(index)
                            })
                            .frame(width: buttonWidth, height: buttonHeight)
                            .buttonStyle(BorderedButtonStyle())
                            .background(colors[index])
                            .foregroundColor(.white)
                            .cornerRadius(buttonCorner)
                        }
                    }
                    .padding(.leading)
                    Text(buttonSelected)
                        .opacity(0)
                }
                Spacer()
                // ouvre les fenetres avec les graphiques
                    .fullScreenCover(isPresented: $showView) {
                        switch buttonSelected {
                        case "Entrées Gratuites":
                            FreeTickets()
                        case "Total entrées":
                            TotalTickets()
                            
                        default:
                            PaidTickets()
                        }
                        
                    }
                
            }
            .navigationTitle("Fréquentation des Musées")
            
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showNextLetter()
            }
        }
    }
    // animation sur le texte
    func showNextLetter() {
        if currentIndex < fullText.count {
            textToShow += String(fullText[fullText.index(fullText.startIndex, offsetBy: currentIndex)])
            currentIndex += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                showNextLetter()
            }
        } else {
            endOfSentance = true
        }
    }
}

#Preview {
    ContentView()
}
