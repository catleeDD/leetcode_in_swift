/*
 169. Majority Element
 
 https://leetcode.com/problems/majority-element/#/description
 
 Given an array of size n, find the majority element. The majority element is the element that appears more than ⌊ n/2 ⌋ times.
 
 You may assume that the array is non-empty and the majority element always exist in the array.
 */

// O(nlogn) sorting
class Solution {
    func majorityElement(_ nums: [Int]) -> Int {
        let nums = nums.sorted()
        return nums[nums.count/2]
    }
}

// O(n) Moore Voting Algorithm
class Solution1 {
    func majorityElement(_ nums: [Int]) -> Int {
        var major = nums[0]
        var count = 1
        for i in 1..<nums.count {
            if count == 0 || major == nums[i] {
                major = nums[i]
                count += 1
            } else {
                count -= 1
            }
        }
        return major
    }
}

// dict
class Solution2 {
    func majorityElement(_ nums: [Int]) -> Int {
        var counts = [Int: Int]()
        for i in 0..<nums.count {
            counts[nums[i]] = (counts[nums[i]] ?? 0) + 1
            if counts[nums[i]]! > nums.count/2 {
                return nums[i]
            }
        }
        return -1
    }
}

// bit manipulation
// http://blog.csdn.net/xsloop/article/details/47006241
class Solution3 {
    func majorityElement(_ nums: [Int]) -> Int {
        var major = 0
        var mask = 1
        //这里一般位位运算是32，swift中得改成64，否则符号会有问题
        (0..<64).forEach { _ in
            var count = 0
            for num in nums {
                if num & mask != 0 {
                    count += 1
                }
                if count > nums.count / 2 {
                    major |= mask
                    break
                }
            }
            mask <<= 1
        }
        return major
    }
}


// 按照顺序循环，如果两个元素不相等，则删除这两个元素。则剩下的为出现大于n/2次的那个元素
class Solution4 {
    func majorityElement(_ nums: [Int]) -> Int {
        return -1
    }
}

// divide and conquer 首先将序列均分成两半，分别找出每一半的主元素。如果两个主元素相等，则直接返回1个；否则遍历完整序列，返回出现次数多于一半的那个主元素。边界条件：序列只有一个元素时，直接返回该元素。

