//
//  InvestViewModel.swift
//  Invest
//
//  Created by user273384 on 4/12/25.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class InvestViewModel : ObservableObject {
    
    @Published var investments = [InvestModel]()
    let db = Firestore.firestore()
    
    func fetchData() {
        self.investments.removeAll()
        db.collection("investments")
            .getDocuments() { (querySnapShot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapShot!.documents {
                        do {
                            self.investments.append(try document.data(as: InvestModel.self))
                        } catch {
                            print(error)
                        }
                    }
                }
            }
    }
    
    func updateData(investment: InvestModel) {
        
        if let id = investment.id {
            
            // Edit investment
            // Make sure value is entered in to field
            if !investment.asset.isEmpty || !investment.numowned.isEmpty {
                
                let docRef = db.collection("investments").document(id)
                
                docRef.updateData([
                    "asset": investment.asset,
                    "currprice": investment.currprice,
                    "numowned": investment.numowned,
                    "value": investment.value
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Investment successfully updated")
                    }
                }
            }
            
        } else {
            
            // Add investment
            // Check if values are entered into fields
            if !investment.asset.isEmpty || !investment.numowned.isEmpty {
                
                var ref: DocumentReference? = nil
                ref = db.collection("investments").addDocument(data: [
                    "asset": investment.asset,
                    "currprice": investment.currprice,
                    "numowned": investment.numowned,
                    "value": investment.value
                ]) { err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Investment added with ID: \(ref!.documentID)")
                    }
                }
            }
        }
    }
}
