import UIKit

// 122. Best Time to Buy and Sell Stock II

// https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/



class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count < 2 { return 0 }
        var buy = false
        var profit = 0
        for i in 1..<prices.count {
            if !buy {
                if prices[i] > prices[i-1] {
                    profit -= prices[i-1]
                    buy = true
                }
            } else {
                if prices[i] < prices[i-1] {
                    profit += prices[i-1]
                    buy = false
                }
            }
        }
        if buy {
            profit += prices[prices.count-1]
        }
        return profit
    }
}


// 看了答案(方法三)，直接每次上涨就加，不用考虑买卖
// https://leetcode-cn.com/problems/best-time-to-buy-and-sell-stock-ii/solution/mai-mai-gu-piao-de-zui-jia-shi-ji-ii-by-leetcode/
class Solution1 {
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count < 2 { return 0 }
        var profit = 0
        for i in 1..<prices.count {
            if prices[i] > prices[i-1] {
                profit += prices[i] - prices[i-1]
            }
        }
        return profit
    }
}
