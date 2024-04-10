//
//  ContentView.swift
//  Graph
//
//  Created by Philippe MICHEL on 09/04/2024.
//

import SwiftUI

struct ContentView: View {
    var connectionmusee:APIConnection = APIConnection()
    @State var buttonPressed:Int?
    @State var showViewGraph:Bool = false
    var body: some View {
        NavigationStack{
            VStack {
                HStack(spacing: 20){
                    Button(action: {
                        buttonPressed = 0
                        self.showViewGraph = true
                    }, label: {
                        Text("Entrées Payantes")
                    })
                    .frame(width: 100, height: 80)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .buttonStyle(BorderedButtonStyle())
                    Button(action: {
                        buttonPressed = 1
                        self.showViewGraph = true
                    }, label: {
                        Text("Entrées Gratuites")
                    })
                    .frame(width: 100, height: 80)
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .buttonStyle(BorderedButtonStyle())
                    Button(action: {
                        buttonPressed = 2
                        self.showViewGraph = true
                    }, label: {
                        Text("Total des entrées")
                    })
                    .frame(width: 100, height: 80)
                    .background(.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .buttonStyle(BorderedButtonStyle())
                }
                .fullScreenCover(isPresented: $showViewGraph) {
                    switch buttonPressed {
                    case 0:
                      PaidTickets()
                    case 1:
                        FreeTickets()
                    default:
                        TotalTickets()
                    }
                }
            }
            .navigationTitle("Fréquentation Musée")
            
            
        }
    }
}

#Preview {
    ContentView()
}
