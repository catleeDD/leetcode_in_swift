import UIKit

// 55. Jump Game

// https://leetcode-cn.com/problems/jump-game/


// 递归，答案应该是对的，但是超时
// 从官方答案看应该是O(2^n)，因为重复计算了很多次
class Solution {
    func canJump(_ nums: [Int]) -> Bool {
        return helper(nums, 0)
    }
    func helper(_ nums: [Int], _ i:Int) -> Bool {
        if nums.count-i == 0 { return false }
        if nums.count-i == 1 { return true }
        if nums[i] == 0 { return false }
        var j = i+1
        while j-i < nums.count && j-i <= nums[i] {
            if helper(nums, j) {
                return true
            }
            j+=1
        }
        return false
    }
}

// 动态规划，使用数组，还是超时了
// 复杂度 On^2
class Solution1 {
    func canJump(_ nums: [Int]) -> Bool {
        if nums.count == 0 { return false }
        if nums.count == 1 { return true }
        if nums[0] == 0 { return false }
        let n = nums.count
        var jumps = Array<Bool>(repeating:false, count:n)
        jumps[n-1] = true
        for i in (0 ..< n-1).reversed() {
            if nums[i] != 0 {
                var j = i+1
                while j < n && j-i <= nums[i] {
                    if jumps[j] {
                        jumps[i] = true
                        break
                    }
                    j+=1
                }
            }
        }
        return jumps[0]
    }
}

// 一个快速的优化方法是我们可以从右到左的检查 nextposition ，理论上最坏的时间复杂度复杂度是一样的。但实际情况下，对于一些简单场景，这个代码可能跑得更快一些。直觉上，就是我们每次选择最大的步数去跳跃，这样就可以更快的到达终点。
// 但是还是超时
// 复杂度 On^2
class Solution2 {
    func canJump(_ nums: [Int]) -> Bool {
        if nums.count == 0 { return false }
        if nums.count == 1 { return true }
        if nums[0] == 0 { return false }
        let n = nums.count
        var jumps = Array<Bool>(repeating:false, count:n)
        jumps[n-1] = true
        for i in (0 ..< n-1).reversed() {
            if nums[i] != 0 {
                var j = min(i+nums[i],n-1)
                while j > i && j < n && j-i <= nums[i] {
                    if jumps[j] {
                        jumps[i] = true
                        break
                    }
                    j-=1
                }
            }
        }
        return jumps[0]
    }
}

// 答案 https://leetcode-cn.com/problems/jump-game/solution/tiao-yue-you-xi-by-leetcode/


// 唯一能过的方法，优化点在于不用一个一个往后遍历（或者往前遍历）去找到第一个true，直接把最左边的true的位置记下来，判断能不能直接走到那个位置即可
// 复杂度 On
class Solution3 {
    func canJump(_ nums: [Int]) -> Bool {
        if nums.count == 0 { return false }
        let n = nums.count
        var lastCanJump = n-1
        for i in (0 ..< n-1).reversed() {
            if i + nums[i] >= lastCanJump {
                lastCanJump = i
            }
        }
        return lastCanJump == 0
    }
}

Solution2().canJump([3,2,1,0,4])
Solution2().canJump([0,1])
Solution2().canJump([0])
Solution2().canJump([2,0])

