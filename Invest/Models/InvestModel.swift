//
//  InvestModel.swift
//  Invest
//
//  Created by user273384 on 4/12/25.
//

import Foundation
import FirebaseFirestore

struct InvestModel : Codable, Identifiable {
    @DocumentID var id: String?
    var asset: String
    var currprice: String
    var numowned: String
    var value: String
    
}
