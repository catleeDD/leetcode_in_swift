/*
 152. Maximum Product Subarray
 
 https://leetcode.com/problems/maximum-product-subarray/description/
 
 Find the contiguous subarray within an array (containing at least one number) which has the largest product.
 
 For example, given the array [2,3,-2,4],
 the contiguous subarray [2,3] has the largest product = 6.
 
 */

// 这道题比https://leetcode.com/problems/maximum-subarray/description/ 难一些，因为要考虑负负得正
class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        var dp = Array<(Int,Int)>(repeating: (1,1), count: nums.count + 1)
        var result = Int.min
        for i in 0..<nums.count {
            let minNum = min(dp[i].0 * nums[i], dp[i].1 * nums[i], nums[i])
            let maxNum = max(dp[i].0 * nums[i], dp[i].1 * nums[i], nums[i])
            dp[i+1] = (minNum, maxNum)
            result = max(result, maxNum)
        }
        return result
    }
}

// 优化空间为o（1）
class Solution1 {
    func maxProduct(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        var minNum = nums[0]
        var maxNum = nums[0]
        var result = nums[0]
        for i in 1..<nums.count {
            let temp = minNum
            minNum = min(minNum * nums[i], maxNum * nums[i], nums[i])
            maxNum = max(temp * nums[i], maxNum * nums[i], nums[i])
            result = max(result, maxNum)
        }
        return result
    }
}

Solution().maxProduct([-2,3,-4])
Solution().maxProduct([0,2])
Solution().maxProduct([-2])