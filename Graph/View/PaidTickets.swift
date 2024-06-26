//
//  PaidTickets.swift
//  Graph
//
//  Created by Philippe MICHEL on 10/04/2024.
//

import SwiftUI
import Charts

struct PaidTickets: View {
    @Environment(\.dismiss) var dismiss
    var connectionmusee:APIConnection = APIConnection()
    var body: some View {
        NavigationStack {
            VStack{
                Chart{
                    ForEach(connectionmusee.listMusee,id: \.ref_musee) {musee  in
                        BarMark(x: .value("Payant",musee.payant ?? 0),        y:.value("Nom",musee.nom_du_musee))
                            .foregroundStyle(.red)
                            .opacity(0.5)
                            // barre en tube 
                            //.clipShape(RoundedRectangle(cornerRadius: 16))
                            .annotation(position:.trailing) {
                                Text(String(musee.payant ?? 0))
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                    }
                }
                .frame(height:350)
                // pas besoin de legende  ici
                //.chartLegend(position: .top,alignment: .leading,spacing: 10)
                // scroll vertical
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
            .navigationTitle("Tickets payants")
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
    PaidTickets()
}
