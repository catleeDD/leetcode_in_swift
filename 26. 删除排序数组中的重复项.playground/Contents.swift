import UIKit

// 26. 删除排序数组中的重复项

// https://leetcode-cn.com/problems/remove-duplicates-from-sorted-array/

class Solution {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count < 2 { return nums.count }
        var i = 0, j = 0
        while j < nums.count {
            while j+1 < nums.count && nums[j] == nums[j+1] {
                j += 1
            }
            j += 1
            if j < nums.count {
                i += 1
                nums[i] = nums[j]
            }
        }
        return i+1
    }
}

// 更优雅的写法
class Solution1 {
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.count < 1 { return nums.count }
        var i = 0
        for j in 1..<nums.count {
            if nums[j] != nums[i] {
                i += 1
                nums[i] = nums[j]
            }
        }
        return i+1
    }
}
