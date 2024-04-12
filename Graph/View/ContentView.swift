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
    
    @State private var textToShow = ""
    @State private var currentIndex = 0
    @State private var endOfSentance:Bool = false
    let fullText = "Insérer facilement des graphiques dans vos applications. Dans cet exemple, j'utilise une API de fréquentation des musées."
    
    var connectionmusee:APIConnection = APIConnection()
    @State var showViewGraphTotal:Bool = false
    @State var showViewGraphPaid:Bool = false
    @State var showViewGraphFree:Bool = false
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
                HStack(spacing: 7){
                    if endOfSentance {
                        Button(action: {
                            // getNumberPress(numberButton: 0)
                            self.showViewGraphPaid.toggle()
                            
                        }, label: {
                            Text("Entrées Payantes")
                                .multilineTextAlignment(.center)
                        })
                        .frame(width: buttonWidth, height: buttonHeight)
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(buttonCorner)
                        .buttonStyle(BorderedButtonStyle())
                        Button(action: {
                            self.showViewGraphFree.toggle()
                            
                            
                        }, label: {
                            Text("Entrées Gratuites")
                                .multilineTextAlignment(.center)
                        })
                        .frame(width: buttonWidth, height: buttonHeight)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(buttonCorner)
                        .buttonStyle(BorderedButtonStyle())
                        Button(action: {
                            self.showViewGraphTotal.toggle()
                        }, label: {
                            Text("Total entrées")
                                .multilineTextAlignment(.center)
                        })
                        .frame(width: buttonWidth, height: buttonHeight)
                        .background(.purple)
                        .foregroundColor(.white)
                        .cornerRadius(buttonCorner)
                        .buttonStyle(BorderedButtonStyle())
                    }
                }
                Spacer()
                // ouvre les fenetres avec les graphiques
                    .fullScreenCover(isPresented: $showViewGraphTotal) {
                        TotalTickets()
                    }
                    .fullScreenCover(isPresented: $showViewGraphPaid) {
                        PaidTickets()
                    }
                
                    .fullScreenCover(isPresented: $showViewGraphFree) {
                        FreeTickets()
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
        // guard currentIndex < fullText.count else { return }
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
