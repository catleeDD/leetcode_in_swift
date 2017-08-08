/*
 238. Product of Array Except Self
 https://leetcode.com/problems/product-of-array-except-self/#/description
 
 Given an array of n integers where n > 1, nums, return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
 
 Solve it without division and in O(n).
 
 For example, given [1,2,3,4], return [24,12,8,6].
 
 Follow up:
 Could you solve it with constant space complexity? (Note: The output array does not count as extra space for the purpose of space complexity analysis.)
*/

class Solution {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var fromBegin = Array<Int>(repeating: 1, count: nums.count)
        var fromEnd = Array<Int>(repeating: 1, count: nums.count)
        for i in 1..<nums.count {
            fromBegin[i] = fromBegin[i-1] * nums[i-1]
            fromEnd[i] = fromEnd[i-1] * nums[nums.count-i]
        }
        print(fromBegin)
        print(fromEnd)
        var result = Array<Int>(repeating: 1, count: nums.count)
        for i in 0..<nums.count {
            result[i] = fromBegin[i] * fromEnd[nums.count-1-i]
        }
        return result
    }
}

Solution().productExceptSelf([1,2,3,4])

class Solution1 {
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var fromBegin = 1
        var fromEnd = 1
        var result = Array<Int>(repeating: 1, count: nums.count)
        for i in 0..<nums.count {
            result[i] *= fromBegin
            fromBegin *= nums[i]
            result[nums.count-1-i] *= fromEnd
            fromEnd *= nums[nums.count-1-i]
        }
        return result
    }
}

Solution1().productExceptSelf([1,2,3,4])
