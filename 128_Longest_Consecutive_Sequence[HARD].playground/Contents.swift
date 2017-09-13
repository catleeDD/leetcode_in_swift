/*
 128. Longest Consecutive Sequence
 https://leetcode.com/problems/longest-consecutive-sequence/description/
 
 Given an unsorted array of integers, find the length of the longest consecutive elements sequence.
 
 For example,
 Given [100, 4, 200, 1, 3, 2],
 The longest consecutive elements sequence is [1, 2, 3, 4]. Return its length: 4.
 
 Your algorithm should run in O(n) complexity.
 */

// http://www.cnblogs.com/grandyang/p/4276225.html
class Solution {
    func longestConsecutive(_ nums: [Int]) -> Int {
        var res = 0
        var set = Set(nums)
        for val in nums {
            if !set.contains(val) { continue }
            set.remove(val)
            var pre = val - 1, next = val + 1
            while set.contains(pre) { set.remove(pre); pre -= 1 }
            while set.contains(next) { set.remove(next); next += 1 }
            res = max(res, next - pre - 1)
        }
        return res
    }
}


// 不好想，保证每次最大和最小的数对应的count是max length
class Solution1 {
    func longestConsecutive(_ nums: [Int]) -> Int {
        var res = 0
        var map = [Int: Int]()
        for val in nums {
            if map.keys.contains(val) { continue }
            let pre = val - 1, next = val + 1
            let left = map[pre] ?? 0
            let right = map[next] ?? 0
            let sum = left + right + 1
            map[val] = sum
            map[val-left] = sum
            map[val+right] = sum
            res = max(res, sum)
        }
        return res
    }
}

// 非常巧妙，每次看当前的数是否是序列的第一个，然后才开始往后数
class Solution2 {
    func longestConsecutive(_ nums: [Int]) -> Int {
        var res = 0
        let set = Set(nums)
        for val in nums {
            if !set.contains(val - 1) {
                var next = val + 1
                while set.contains(next) {
                    next += 1
                }
                res = max(res, next-val)
            }
        }
        return res
    }
}

Solution2().longestConsecutive([100, 4, 200, 1, 3, 2])
