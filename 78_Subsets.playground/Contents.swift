/*
 78. Subsets
 https://leetcode.com/problems/subsets/description/
 
 Given a set of distinct integers, nums, return all possible subsets.
 
 Note: The solution set must not contain duplicate subsets.
 
 For example,
 If nums = [1,2,3], a solution is:
 
 [
 [3],
 [1],
 [2],
 [1,2,3],
 [1,3],
 [2,3],
 [1,2],
 []
 ]
 
 */

// 这道题可以参考 46. Permutations，有相似之处

import Foundation

class Solution {
    private var result = [[Int]]()
    func subsets(_ nums: [Int]) -> [[Int]] {
        helper(nums, 0, [])
        return result
    }
    
    private func helper(_ nums: [Int], _ start: Int, _ temp: [Int]) {
        result.append(temp)
        if start == nums.count {
            return
        }
        for i in start..<nums.count{
            helper(nums, i+1, temp + [nums[i]])
        }
    }
}

// Iterative
// 思想其实是动态规划，当只有一个数的时候只有两种结果，两个数就是在一个数结果的基础上组合上有没有第二个数。
// 动态规划其实就是循环
class Solution1 {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        result.append([])
        for num in nums {
            for i in 0..<result.count {
                result.append(result[i]+[num])
            }
        }
        return result
    }
}

// Bit Manipulation
class Solution2 {
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        let n = Int(pow(Double(2), Double(nums.count)))
        for i in 0..<n {
            var temp = [Int]()
            for j in 0..<nums.count {
                if (i>>j)&1 == 1 {
                    temp.append(nums[j])
                }
            }
            result.append(temp)
        }
        return result
    }
}


Solution().subsets([1,2,3])
Solution1().subsets([1,2,3])
Solution2().subsets([1,2,3])
