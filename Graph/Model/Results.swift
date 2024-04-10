//
//  Results.swift
//  Graph
//
//  Created by Philippe MICHEL on 09/04/2024.
//

import Foundation
struct APIreults:Decodable {
    var results:[detailMusee]
}

struct detailMusee:Decodable {
    var ref_musee:String
    var nom_du_musee:String
    var annee:String
    var regions:String
    var ville:String
    var date_appellation:String
    var payant:Int64?
    var gratuit:Int64?
    var total:Int64?
    var note:String?
    var id_museofile:Int64?
    var nomdep:String
    var observations:String?
}
