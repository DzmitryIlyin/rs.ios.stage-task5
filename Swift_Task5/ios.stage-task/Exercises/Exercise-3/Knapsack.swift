import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    func findMaxKilometres() -> Int {
        let foodsKnapsack = fillKnapsack(items: foods)
        let drinksKnapsack = fillKnapsack(items: drinks)
        
        var maxKilometers = 0
        for i in 1...maxWeight {
            let min = min(foodsKnapsack[foodsKnapsack.count - 1][i], drinksKnapsack[drinksKnapsack.count - 1][maxWeight - i])
            maxKilometers = min > maxKilometers ? min : maxKilometers
        }
        return maxKilometers
    }
    
    func fillKnapsack(items: Array<Supply>) -> Array<Array<Int>> {
        let valuesCount = items.count
        var t = Array(repeating: Array(repeating: 0,count: maxWeight+1), count: valuesCount+1)
        for i in 1 ..< valuesCount+1 {
            for j in 1 ..< maxWeight+1 {
                if items[i-1].weight <= j {
                    t[i][j] = max(t[i-1][j-items[i-1].weight] + items[i-1].value, t[i-1][j])
                } else {
                    t[i][j] = t[i-1][j]
                }
            }
        }
        return t
    }
}
