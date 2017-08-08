/*
 198. House Robber
 https://leetcode.com/problems/house-robber/#/description
 
 You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and it will automatically contact the police if two adjacent houses were broken into on the same night.
 
 Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.
 */


// dp[i] = max(nums[i] + dp[i-2], nums[i-1] + dp[i-3])
// dp[i]表示抢劫前i+1所房子
class Solution {
    func rob(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0 }
        let n = nums.count
        var nums = nums
        var dp = Array<Int>(repeating: 0, count: n)
        for i in 0..<n {
            if i == 0 {
                dp[i] = nums[i]
            } else if i == 1 {
                dp[i] = max(nums[i], nums[i-1])
            } else if i == 2 {
                dp[i] = max(nums[i] + dp[i - 2], nums[i - 1])
            } else {
                dp[i] = max(nums[i] + dp[i - 2], nums[i - 1] + dp[i - 3])
            }
        }
        return dp[n-1]
    }
}

Solution().rob([1,2,3,4])

// dp[i][1]表示会抢劫当前房子，dp[i][0]表示不会
class Solution1 {
    func rob(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0 }
        let n = nums.count
        var dp = Array<Array<Int>>(repeating: Array<Int>(repeating: 0, count: 2), count: n+1)
        for i in 1...n {
            dp[i][0] = max(dp[i-1][0], dp[i-1][1])
            dp[i][1] = nums[i-1] + dp[i-1][0]
        }
        return max(dp[n][0], dp[n][1])
    }
}

// 优化成O(1)的space
class Solution2 {
    func rob(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0 }
        let n = nums.count
        var prevNo = 0, prevYes = 0
        for i in 0..<n {
            let temp = prevNo
            prevNo = max(prevNo, prevYes)
            prevYes = nums[i] + temp
        }
        return max(prevNo, prevYes)
    }
}

Solution2().rob([1,2,3,4])
