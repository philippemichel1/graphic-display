//
//  TotalTicket.swift
//  Graph
//
//  Created by Philippe MICHEL on 10/04/2024.
//

import SwiftUI
import Charts

struct TotalTickets: View {
    @Environment(\.dismiss) var dismiss
    var connectionmusee:APIConnection = APIConnection()
    var body: some View {
        NavigationStack {
            VStack{
                Chart{
                    ForEach(connectionmusee.listMusee,id: \.ref_musee) {musee  in
                        BarMark(x: .value("Total",musee.total ?? 0),        y:.value("Nom",musee.nom_du_musee))
                            .foregroundStyle(.purple)
                            .opacity(0.5)
                            .annotation(position:.trailing) {
                                Text(String(musee.total ?? 0))
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: Resource.image.closeWindow.rawValue)
                        }
                    }
                }
            }
            .chartLegend(.visible)
            .navigationTitle("Total tickets")
            .padding()
        }
        // affichage de la vue
        .onAppear {
            Task {
                await connectionmusee.connectJson()
            }
            
            
        }
        // on quitte la vue
        .onDisappear {
            connectionmusee.listMusee.removeAll()
        }
        
        
        
    }
    
}

#Preview {
    TotalTickets()
}
