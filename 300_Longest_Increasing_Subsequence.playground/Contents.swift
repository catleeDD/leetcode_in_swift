/*
 300. Longest Increasing Subsequence
 
 https://leetcode.com/problems/longest-increasing-subsequence/description/
 
 Given an unsorted array of integers, find the length of longest increasing subsequence.
 
 For example,
 Given [10, 9, 2, 5, 3, 7, 101, 18],
 The longest increasing subsequence is [2, 3, 7, 101], therefore the length is 4. Note that there may be more than one LIS combination, it is only necessary for you to return the length.
 
 Your algorithm should run in O(n2) complexity.
 
 Follow up: Could you improve it to O(n log n) time complexity?
 */

// dp o(n^2)
class Solution {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        var result = 1
        var dp = Array<Int>(repeating: 1, count: nums.count)
        for i in 1..<nums.count {
            for j in 0..<i {
                if nums[j] < nums[i] {
                    dp[i] = max(dp[i], dp[j]+1)
                }
            }
            result = max(dp[i], result)
        }
        
        return result
    }
}

// o(nlogn)
class Solution1 {
    func lengthOfLIS(_ nums: [Int]) -> Int {
        guard nums.count > 0 else {
            return 0
        }
        var tails = [Int]()
        tails.append(nums[0])
        for i in 1..<nums.count {
            if nums[i] < tails[0] {
                tails[0] = nums[i]
            } else if nums[i] > tails[tails.count - 1] {
                tails.append(nums[i])
            } else {
                tails[ceil(tails, 0, tails.count-1, nums[i])] = nums[i]
            }
        }
        return tails.count
    }
    
    private func ceil(_ nums: [Int], _ lo: Int, _ hi: Int, _ target: Int) -> Int {
        var i = lo
        var j = hi
        while i <= j {
            let mid = i + (j-i) / 2
            if nums[mid] < target {
                i = mid + 1
            } else {
                j = mid - 1
            }
        }
        return i
    }
}
