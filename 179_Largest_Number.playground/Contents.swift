/*
 179. Largest Number
 https://leetcode.com/problems/largest-number/#/description
 
 Given a list of non negative integers, arrange them such that they form the largest number.
 
 For example, given [3, 30, 34, 5, 9], the largest formed number is 9534330.
 
 Note: The result may be very large, so you need to return a string instead of an integer.
 */

class Solution {
    func largestNumber(_ nums: [Int]) -> String {
        let strs = nums.map { String($0) }
        return strs.sorted { ($0 + $1) > ($1 + $0) }.reduce("") { $0 + $1 }
    }
}

Solution().largestNumber([3, 30, 34, 5, 9])
