import UIKit

// 384. Shuffle an Array
// https://leetcode-cn.com/problems/shuffle-an-array/

class Solution {

    var originNums: [Int]
    init(_ nums: [Int]) {
        self.originNums = nums
    }
    
    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        return self.originNums
    }
    
    /** Returns a random shuffling of the array. */
    func shuffle() -> [Int] {
        var ret = self.originNums
        for i in (0..<ret.count).reversed() {
            let r = Int.random(in: 0...i)
            ret.swapAt(r, i)
        }
        return ret
    }
}

// [1,2,3]

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(nums)
 * let ret_1: [Int] = obj.reset()
 * let ret_2: [Int] = obj.shuffle()
 */

Int.random(in: 0...5)
