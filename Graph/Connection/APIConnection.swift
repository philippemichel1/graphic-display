//
//  APIConnection.swift
//  Graph
//
//  Created by Philippe MICHEL on 09/04/2024.
//

import Foundation
import SwiftUI


@Observable
class APIConnection {
    
    var listMusee:[detailMusee] = []
    
    func connectJson() async  {
        let statusTache = Task {() in
            // verification chaine de type url
            guard let urlString = URL(string: "https://data.culture.gouv.fr/api/explore/v2.1/catalog/datasets/frequentation-des-musees-de-france/records?limit=10") else {return}
            do {
                // connexion url session
                let (myData, _) = try await URLSession.shared.data(from: urlString)
                let musee = try JSONDecoder().decode(APIreults.self, from: myData)
                print(musee.results.count)
                listMusee = musee.results
                sortMuseeName()
                
            } catch {
                print(error)
                print(error.localizedDescription)
            }
        }
        
    }
    //Trier element du tableau par musée par ordre alphabetique
    func sortMuseeName()  {
        listMusee.sort {$0.nom_du_musee < $1.nom_du_musee}
    }
    
}














