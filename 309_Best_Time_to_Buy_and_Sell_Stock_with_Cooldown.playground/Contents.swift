/*
 309. Best Time to Buy and Sell Stock with Cooldown
 https://leetcode.com/problems/best-time-to-buy-and-sell-stock-with-cooldown/#/description
 
 Say you have an array for which the ith element is the price of a given stock on day i.
 
 Design an algorithm to find the maximum profit. You may complete as many transactions as you like (ie, buy one and sell one share of the stock multiple times) with the following restrictions:
 
 You may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).
 After you sell your stock, you cannot buy stock on next day. (ie, cooldown 1 day)
 Example:
 
 prices = [1, 2, 3, 0, 2]
 maxProfit = 3
 transactions = [buy, sell, cooldown, buy, sell]
 */

// dp两步：1 定义状态 2 写递推式
/*
 1. Define States
 
 To represent the decision at index i:
 
 buy[i]: Max profit till index i. The series of transaction is ending with a buy.
 sell[i]: Max profit till index i. The series of transaction is ending with a sell.
 To clarify:
 
 Till index i, the buy / sell action must happen and must be the last action. It may not happen at index i. It may happen at i - 1, i - 2, ... 0.
 In the end n - 1, return sell[n - 1]. Apparently we cannot finally end up with a buy. In that case, we would rather take a rest at n - 1.
 For special case no transaction at all, classify it as sell[i], so that in the end, we can still return sell[n - 1]. Thanks @alex153 @kennethliaoke @anshu2.
 2. Define Recursion
 
 buy[i]: To make a decision whether to buy at i, we either take a rest, by just using the old decision at i - 1, or sell at/before i - 2, then buy at i, We cannot sell at i - 1, then buy at i, because of cooldown.
 sell[i]: To make a decision whether to sell at i, we either take a rest, by just using the old decision at i - 1, or buy at/before i - 1, then sell at i.
 So we get the following formula:
 
 buy[i] = Math.max(buy[i - 1], sell[i - 2] - prices[i]);
 sell[i] = Math.max(sell[i - 1], buy[i - 1] + prices[i]);
 */
class Solution {
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count <= 1 {
            return 0
        }
        if prices.count == 2 {
            return max(0, prices[1]-prices[0])
        }
        var buy = Array<Int>(repeating: 0, count: prices.count)
        var sell = Array<Int>(repeating: 0, count: prices.count)
        buy[0] = -prices[0]
        buy[1] = max(buy[0], -prices[1])
        sell[0] = 0
        sell[1] = max(sell[0], buy[0]+prices[1])
        for i in 2..<prices.count {
            buy[i] = max(buy[i-1], sell[i-2] - prices[i])
            sell[i] = max(sell[i-1], buy[i-1] + prices[i])
        }
        return sell[prices.count - 1]
    }
}

Solution().maxProfit([1, 2, 3, 0, 2])

// dp如果看状态只依赖前面几个变量，就可以优化空间
/*
 3. Optimize to O(1) Space
 
 DP solution only depending on i - 1 and i - 2 can be optimized using O(1) space.
 
 Let b2, b1, b0 represent buy[i - 2], buy[i - 1], buy[i]
 Let s2, s1, s0 represent sell[i - 2], sell[i - 1], sell[i]
 Then arrays turn into Fibonacci like recursion:
 
 b0 = Math.max(b1, s2 - prices[i]);
 s0 = Math.max(s1, b1 + prices[i]);
 */

class Solution1 {
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.count <= 1 {
            return 0
        }
        var buy0 = -prices[0], buy1 = buy0
        var sell0 = 0, sell1 = 0, sell2 = 0
        for i in 1..<prices.count {
            buy0 = max(buy1, sell2 - prices[i])
            sell0 = max(sell1, buy1 + prices[i])
            buy1 = buy0
            sell2 = sell1
            sell1 = sell0
        }
        return sell0
    }
}

Solution1().maxProfit([1, 2, 3, 0, 2])