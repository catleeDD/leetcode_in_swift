/*
 46. Permutations
 
 https://leetcode.com/problems/permutations/description/
 
 Given a collection of distinct numbers, return all possible permutations.
 
 For example,
 [1,2,3] have the following permutations:
 [
 [1,2,3],
 [1,3,2],
 [2,1,3],
 [2,3,1],
 [3,1,2],
 [3,2,1]
 ]
 
 */

// 这道题可以参考 78. Subsets，有相似之处
// 一共有n！个

// 标准做法是backtrack
// https://leetcode.com/problems/permutations/discuss/18239/A-general-approach-to-backtracking-questions-in-Java-(Subsets-Permutations-Combination-Sum-Palindrome-Partioning)

// 下面做法不是很标准
class Solution {
    private var result = [[Int]]()
    func permute(_ nums: [Int]) -> [[Int]] {
        helper(nums.count, nums, [])
        return result
    }
    
    private func helper(_ n: Int, _ nums: [Int], _ temp: [Int]) {
        if temp.count == n {
            result.append(temp)
            return
        }
        for i in 0..<nums.count {
            helper(n, Array(nums[0..<i] + nums[i+1..<nums.count]), temp + [nums[i]])
        }
    }
}

// 因为题目是distint number，可以直接判断是否包含就行
class Solution1 {
    private var result = [[Int]]()
    func permute(_ nums: [Int]) -> [[Int]] {
        helper(nums, [])
        return result
    }
    
    private func helper(_ nums: [Int], _ temp: [Int]) {
        if temp.count == nums.count {
            result.append(temp)
            return
        }
        for i in 0..<nums.count {
            if temp.contains(nums[i]) {
                continue
            }
            helper(nums, temp + [nums[i]])
        }
    }
}

class Solution2 {
    func permute(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        result.append([])
        for num in nums {
            var arr = [[Int]]()
            for r in result {
                for i in 0..<r.count {
                    var t = r
                    t.insert(num, at: i)
                    arr.append(t)
                }
                var t = r
                t.append(num)
                arr.append(t)
            }
            result = arr
        }
        return result
    }
}

Solution().permute([1,2,3,4,5])
Solution1().permute([1,2,3])
