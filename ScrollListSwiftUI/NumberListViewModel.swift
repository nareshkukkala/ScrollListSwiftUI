//
//  NumberListViewModel.swift
//  ScrollListSwiftUI
//
//  Created by naresh kukkala on 03/05/22.
//

import SwiftUI

class NumberListViewModel: ObservableObject {
    
    @Published var numbers: [Int] = []
    
    func populateData(page: Int) {
        
        guard let url = URL(string: "https://island-bramble.glitch.me/data?page=\(page)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data, error == nil else {
                return
            }
            
            let numbers = try? JSONDecoder().decode([Int].self, from: data)
            DispatchQueue.main.async {
                self.numbers.append(contentsOf: numbers ?? [])
            }
            
        }.resume()
    }
    
    func shouldLoadData(id: Int) -> Bool {
        return id == numbers.count - 2
    }
    
}
