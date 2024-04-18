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
                        // modifie la barre en tube
                            //.clipShape(RoundedRectangle(cornerRadius: 16))
                        // corner radius (arrondis simplement le bout)
                            //.cornerRadius(20)
                            .annotation(position:.trailing) {
                                Text(String(musee.total ?? 0))
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                    }
                }
                .frame(height:350)
                // pas besoin de legende  ici 
                //.chartLegend(position: .top,alignment: .leading,spacing: 10)
                // scroll vertical du graphique
                .chartScrollableAxes(.vertical)
                // nombre de lignes visible dans le graphique
                .chartYVisibleDomain(length: 6)
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
            .navigationTitle("Total tickets")
            
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
