//
//  Order.swift
//  CupCakeCorner
//
//  Created by Grey  on 21.02.2024.
//

import SwiftUI

@Observable
class Order: ObservableObject,Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    func isValidAddress() -> Bool {
        for field in [name, streetAddress, city, zip] {
            if field.trimmingCharacters(in: .whitespaces).isEmpty { return false }
        }
        return true
    }
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    // Save the delivery address to UserDefaults
        func saveToUserDefaults() {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self) {
                UserDefaults.standard.set(encoded, forKey: "savedOrder")
            }
        }
    
    // Load the delivery address from UserDefaults
        func loadFromUserDefaults() {
            if let savedOrder = UserDefaults.standard.data(forKey: "savedOrder") {
                let decoder = JSONDecoder()
                if let loadedOrder = try? decoder.decode(Order.self, from: savedOrder) {
                    // Update the current order with the loaded values
                    self.name = loadedOrder.name
                    self.streetAddress = loadedOrder.streetAddress
                    self.city = loadedOrder.city
                    self.zip = loadedOrder.zip
                }
            }
        }
}
