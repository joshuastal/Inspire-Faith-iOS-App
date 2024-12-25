import Foundation
import SwiftUI
import FirebaseCore
import FirebaseFirestore

func firestoreWritingTest(db: Firestore) {
    db.collection("test").addDocument(data: ["test": true]) { error in
        if let error = error {
            print("Error writing to Firebase: \(error)")
        } else {
            print("Successfully wrote to Firebase!")
        }
    }
}

func firestoreReadingTest(db: Firestore) {
    db.collection("Quotes").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching quotes: \(error)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No documents found")
                return
            }
            
            print("\n=== Quotes Collection Contents ===")
            for doc in documents {
                print("\nDocument ID: \(doc.documentID)")
                let data = doc.data()
                for (field, value) in data {
                    print("\(field): \(value)")
                }
            }
            print("\n================================")
        }
}

