//
//  FreeTickets.swift
//  Graph
//
//  Created by Philippe MICHEL on 10/04/2024.
//

import SwiftUI
import Charts

struct FreeTickets: View {
    @Environment(\.dismiss) var dismiss
    var connectionmusee:APIConnection = APIConnection()
    var body: some View {
        NavigationStack {
            VStack{
                Chart{
                    ForEach(connectionmusee.listMusee,id: \.ref_musee) {musee  in
                        BarMark(x: .value("Gratuit",musee.gratuit ?? 0),        y:.value("Nom",musee.nom_du_musee))
                            .foregroundStyle(.green)
                            .opacity(0.5)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .annotation(position:.trailing) {
                                Text(String(musee.gratuit ?? 0))
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                    }
                }
                .frame(height:350)
                // scroll vertical du graphique
                .chartScrollableAxes(.vertical)
                // nombre elements visible
                .chartYVisibleDomain(length: 6)
                .chartLegend(.visible)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: Resource.image.closeWindow.rawValue)
                        }
                    }
                }
                Spacer()
            }
            .chartLegend(.visible)
            .navigationTitle("Tickets gratuits")
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
    FreeTickets()
}
