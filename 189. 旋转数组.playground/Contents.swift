import UIKit

// 189. 旋转数组
// https://leetcode-cn.com/problems/rotate-array/


// 这是错误解法
class Solution0 {
    func rotate(_ nums: inout [Int], _ k: Int) {
        if k == 0 || k == nums.count || nums.count < 2 { return }
        var i = 0, val = nums[0]
        for _ in 0..<nums.count {
            i = (i + k) % nums.count
            let temp = nums[i]
            nums[i] = val
            val = temp
        }
    }
}


// 看答案https://leetcode-cn.com/problems/rotate-array/solution/xuan-zhuan-shu-zu-by-leetcode/

// 使用环状替换，对于上面的错误解法，对于n%k==0的情况，（比如6%2==0），只会在第0，2，4，0，2，4循环，此时需要从第2位开始再次循环一遍，当所有n个数字都替换了结束

class Solution {
    func rotate(_ nums: inout [Int], _ k: Int) {
        if k == 0 || k == nums.count || nums.count < 2 { return }
        var start = 0
        var count = 0
        while count < nums.count {
            var i = start
            var prev = nums[i]
            repeat {
                i = (i + k) % nums.count
                let temp = nums[i]
                nums[i] = prev
                prev = temp
                count += 1
            } while i != start
            start += 1
        }
    }
}


// 方法二，比较巧妙，三次revert

class Solution1 {
    func rotate(_ nums: inout [Int], _ k: Int) {
        if k == 0 || k == nums.count || nums.count < 2 { return }
        let k = k % nums.count
        reverse(&nums, 0, nums.count-1)
        reverse(&nums, 0, k-1)
        reverse(&nums, k, nums.count-1)
    }
    func reverse(_ nums: inout [Int], _ i: Int, _ j: Int) {
        var i = i, j = j
        while i <= j {
            nums.swapAt(i, j)
            i += 1
            j -= 1
        }
    }
}
