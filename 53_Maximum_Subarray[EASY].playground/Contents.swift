/*
 53. Maximum Subarray
 https://leetcode.com/problems/maximum-subarray/#/description
 
 Find the contiguous subarray within an array (containing at least one number) which has the largest sum.
 
 For example, given the array [-2,1,-3,4,-1,2,1,-5,4],
 the contiguous subarray [4,-1,2,1] has the largest sum = 6.
 
 
 More practice:
 If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.
 */

class Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        var maxCurrent = nums[0]
        var maxSoFar = nums[0]
        for i in 1..<nums.count {
            maxCurrent = max(maxCurrent+nums[i], nums[i])
            maxSoFar = max(maxSoFar, maxCurrent)
        }
        return maxSoFar
    }
}

Solution().maxSubArray([-2,1,-3,4,-1,2,1,-5,4])

class Solution1 {
    func maxSubArray(_ nums: [Int]) -> Int {
        if nums.count == 0 {
            return Int.min
        }
        if nums.count == 1 {
            return nums[0]
        }
        let mid = (nums.count - 1)/2
        let lmax = maxSubArray(Array(nums[0..<mid]))
        let rmax = maxSubArray(Array(nums[mid+1..<nums.count]))
        var mmax = nums[mid]
        var temp = mmax
        for i in (0..<mid).reversed() {
            temp += nums[i]
            mmax = max(mmax, temp)
        }
        temp = mmax
        for i in mid+1..<nums.count {
            temp += nums[i]
            mmax = max(mmax, temp)
        }
        return max(mmax, lmax, rmax)
    }
}

Solution1().maxSubArray([-2,9,8,-4,6])