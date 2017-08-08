/*
 283. Move Zeroes
 https://leetcode.com/problems/move-zeroes/#/description
 
 Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.
 
 For example, given nums = [0, 1, 0, 3, 12], after calling your function, nums should be [1, 3, 12, 0, 0].
 
 Note:
 You must do this in-place without making a copy of the array.
 Minimize the total number of operations.
 */

class Solution {
    func moveZeroes(_ nums: inout [Int]) {
        guard nums.count > 0 else {
            return
        }
        for i in 1..<nums.count {
            var j = i
            while j > 0, nums[j] != 0, nums[j-1] == 0 {
                swap(&nums[j], &nums[j-1])
                j -= 1
            }
        }
    }
}

var arr = [0,1,0]
Solution().moveZeroes(&arr)

// 优化，直接用个全局的pos来记录左边的指针，省去判断左边是否为0
class Solution1 {
    func moveZeroes(_ nums: inout [Int]) {
        guard nums.count > 0 else {
            return
        }
        var j = 0
        for i in 1..<nums.count {
            if nums[i] != 0 {
                swap(&nums[j], &nums[i])
                j += 1
            }
        }
    }
}

// 继续优化
class Solution2 {
    func moveZeroes(_ nums: inout [Int]) {
        guard nums.count > 0 else {
            return
        }
        var j = 0
        for i in 0..<nums.count {
            if nums[i] != 0 {
                nums[j] = nums[i]
                j += 1
            }
        }
        while j < nums.count {
            nums[j] = 0
            j += 1
        }
    }
}

var arr1 = [0,1,0]
Solution2().moveZeroes(&arr)