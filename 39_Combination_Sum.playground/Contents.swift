/*
 39. Combination Sum
 https://leetcode.com/problems/combination-sum/#/description
 Given a set of candidate numbers (C) (without duplicates) and a target number (T), find all unique combinations in C where the candidate numbers sums to T.
 
 The same repeated number may be chosen from C unlimited number of times.
 
 Note:
 All numbers (including target) will be positive integers.
 The solution set must not contain duplicate combinations.
 For example, given candidate set [2, 3, 6, 7] and target 7,
 A solution set is:
 [
   [7],
   [2, 2, 3]
 ]
 
 */

// 回溯
// leedcode上第一个答案介绍了所有使用回溯的算法，值得一看
class Solution {
    var result = [[Int]]()
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        var temp = [Int]()
        helper(candidates, target, 0, &temp)
        return result
    }
    
    private func helper(_ candidates: [Int], _ target: Int, _ start: Int, _ temp: inout [Int]) {
        if target <= 0 {
            if target == 0 {
                result.append(temp)
            }
            return
        }
        for i in start..<candidates.count {
            temp.append(candidates[i])
            // 注意这里传入i来防止重复的结果（每次只用i和i后面的数）
            helper(candidates, target - candidates[i], i, &temp)
            temp.removeLast()
        }
    }
}

// 其实回溯法不用inout也可以实现，如果直接是值传递的话就不需要再将数组remove了
class Solution1 {
    var result = [[Int]]()
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let temp = [Int]()
        helper(candidates, target, 0, temp)
        return result
    }
    
    private func helper(_ candidates: [Int], _ target: Int, _ start: Int, _ temp: [Int]) {
        if target <= 0 {
            if target == 0 {
                result.append(temp)
            }
            return
        }
        for i in start..<candidates.count {
            var new = temp
            new.append(candidates[i])
            // 注意这里传入i来防止重复的结果（每次只用i和i后面的数）
            helper(candidates, target - candidates[i], i, new)
        }
    }
}

Solution().combinationSum([2, 3, 6, 7], 7)
Solution1().combinationSum([2, 3, 6, 7], 7)
