/*
 33. Search in Rotated Sorted Array
 https://leetcode.com/problems/search-in-rotated-sorted-array/#/description
 
 Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.
 
 (i.e., 0 1 2 4 5 6 7 might become 4 5 6 7 0 1 2).
 
 You are given a target value to search. If found in the array return its index, otherwise return -1.
 
 You may assume no duplicate exists in the array.
 */

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var lo = 0
        var hi = nums.count - 1
        while lo <= hi {
            let mid = lo + (hi - lo) / 2
            if nums[mid] == target {
                return mid
            }
            // targe和mid都在一边
            if (target >= nums[0] && nums[mid] >= nums[0]) || (target <= nums[nums.count-1] && nums[mid] <= nums[nums.count-1]) {
                if nums[mid] < target {
                    lo = mid + 1
                } else {
                    hi = mid - 1
                }
            } else if nums[mid] >= nums[0] {
                lo = mid + 1
            } else {
                hi = mid - 1
            }
        }
        return -1
    }
}

class Solution1 {
    func search(_ nums: [Int], _ target: Int) -> Int {
        var lo = 0
        var hi = nums.count - 1
        while lo <= hi {
            let mid = lo + (hi - lo) / 2
            if nums[mid] == target {
                return mid
            }
            // mid在左边
            if nums[0] <= nums[mid] {
                if target >= nums[0], target < nums[mid] {
                    hi = mid - 1
                } else {
                    lo = mid + 1
                }
            } else {
                if target <= nums[nums.count - 1], target > nums[mid] {
                    lo = mid + 1
                } else {
                    hi = mid - 1
                }
            }
        }
        return -1
    }
}

Solution1().search([3,5,6,7,1,2], 8)