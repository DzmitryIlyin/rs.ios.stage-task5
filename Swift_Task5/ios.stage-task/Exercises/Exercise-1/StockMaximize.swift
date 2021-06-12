import Foundation

class StockMaximize {
    
    func countProfit(prices: [Int]) -> Int {
        
        var result = 0
        if prices.count == 0 {return result}
        
        outerLoop: for i in 0..<prices.count {
            var tempMax = 0
            innerLoop: for j in i+1..<prices.count {
                if prices[i] > prices[j] {
                    continue innerLoop
                } else if (prices[j] - prices[i] > tempMax){
                    tempMax = prices[j] - prices[i]
                }
            }
            result += tempMax
        }
        
        return result
    }
}
