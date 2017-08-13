/*
 34. Search for a Range
 https://leetcode.com/problems/search-for-a-range/description/
 
 Given an array of integers sorted in ascending order, find the starting and ending position of a given target value.
 
 Your algorithm's runtime complexity must be in the order of O(log n).
 
 If the target is not found in the array, return [-1, -1].
 
 For example,
 Given [5, 7, 7, 8, 8, 10] and target value 8,
 return [3, 4].
 */

// 自己想出的方法，先找到，然后向两边扩展
class Solution {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var i = 0
        var j = nums.count-1 // 注意
        while i <= j { //注意符号
            let mid = i + (j-i) / 2
            if nums[mid] == target {
                var start = mid
                var end = mid
                while start > 0, nums[start-1] == target {
                    start -= 1
                }
                while end < nums.count-1, nums[end+1] == target {
                    end += 1
                }
                return [start, end]
            }
            if nums[mid] < target {
                i = mid + 1
            } else {
                j = mid - 1 // 注意
            }
        }
        return [-1,-1]
    }
}

// 找到ceil
class Solution1 {
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        let start = ceil(nums, target)
        if start == nums.count || nums[start] != target {
            return [-1,-1]
        }
        return [start, ceil(nums, target + 1) - 1]
    }
    
    // 最终可能为nums.count
    func ceil(_ nums: [Int], _ target: Int) -> Int {
        var i = 0
        var j = nums.count - 1
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

Solution1().searchRange([5, 7, 7, 8, 8, 10], 7)
Solution1().ceil([5, 7, 7, 8, 8, 10], 11)
