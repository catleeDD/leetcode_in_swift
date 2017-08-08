/*
 414. Third Maximum Number
 
 https://leetcode.com/problems/third-maximum-number/#/description
 
 Given a non-empty array of integers, return the third maximum number in this array. If it does not exist, return the maximum number. The time complexity must be in O(n).
 
 Example 1:
 Input: [3, 2, 1]
 
 Output: 1
 
 Explanation: The third maximum is 1.
 Example 2:
 Input: [1, 2]
 
 Output: 2
 
 Explanation: The third maximum does not exist, so the maximum (2) is returned instead.
 Example 3:
 Input: [2, 2, 3, 1]
 
 Output: 1
 
 Explanation: Note that the third maximum here means the third maximum distinct number.
 Both numbers with value 2 are both considered as second maximum.
 
 */

// 三次循环
class Solution {
    func thirdMax(_ nums: [Int]) -> Int {
        var maxs = [Int]()
        for _ in 0..<3 {
            if let max = findMax(nums, below: maxs.last ?? Int.max) {
                maxs.append(max)
            }
        }
        return maxs.count == 3 ? maxs[2] : maxs[0]
    }
    
    func findMax(_ nums: [Int], below: Int) -> Int? {
        var max = Int.min
        for num in nums {
            if num >= max, num < below {
                max = num
            }
        }
        return max >= below || max == Int.min ? nil : max
    }
}

//一次循环 很巧妙
class Solution1 {
    func thirdMax(_ nums: [Int]) -> Int {
        var max1: Int?
        var max2: Int?
        var max3: Int?
        for num in nums {
            if num == max1 || num == max2 || num == max3 {
                continue
            }
            if max1 == nil || num > max1! {
                max3 = max2
                max2 = max1
                max1 = num
            } else if max2 == nil || num > max2! {
                max3 = max2
                max2 = num
            } else if max3 == nil || num > max3! {
                max3 = num
            }
        }
        return max3 == nil ? max1! : max3!
    }
}


Solution1().thirdMax([2,1,3])

