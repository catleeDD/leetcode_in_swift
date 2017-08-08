/*
 136. Single Number
 Given an array of integers, every element appears twice except for one. Find that single one.
 
 Note:
 Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?
 
 */

class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var set = Set<Int>()
        for num in nums {
            if set.contains(num) {
                set.remove(num)
            } else {
                set.insert(num)
            }
        }
        return set.first!
    }
}


// A ^ A = 0 and A ^ B ^ A = B.
class Solution1 {
    func singleNumber(_ nums: [Int]) -> Int {
        var result = nums[0]
        for i in 1..<nums.count {
            result ^= nums[i]
        }
        return result
    }
}