//: Playground - noun: a place where people can play

import UIKit

/*
 
 216. Combination Sum III
 
 Find all possible combinations of k numbers that add up to a number n, given that only numbers from 1 to 9 can be used and each combination should be a unique set of numbers.
 
 
 Example 1:
 
 Input: k = 3, n = 7
 
 Output:
 
 [[1,2,4]]
 
 Example 2:
 
 Input: k = 3, n = 9
 
 Output:
 
 [[1,2,6], [1,3,5], [2,3,4]]
 
 */

// 正常解法 backtracking（回溯）
class Solution {
    var result = [[Int]]()
    
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        var temp = [Int]()
        helper(&temp, k, n)
        return result
    }
    
    func helper(_ temp: inout [Int], _ k: Int, _ n: Int) {
        if temp.count == k {
            if n == 0 {
                result.append(temp)
            }
        } else {
            let start = (temp.last ?? 0) + 1
            if start <= 9 {
                for i in start...9 {
                    temp.append(i)
                    helper(&temp, k, n - i)
                    temp.removeLast()
                }
            }
        }
    }
}

// DirGoTii 奇葩解法
class Solution1 {
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        var result: [[Int]] = []
        with(base: [], more: k) {
            if $0.reduce(0, +) == n {
                result.append($0)
            }
        }
        return result
    }
    
    private func with(base: [Int], more: Int, block: ([Int]) -> Void) {
        let from = (base.last ?? 0) + 1
        guard from <= 9 else {
            return
        }
        if more == 1 {
            (from...9).forEach {
                var result = base
                result.append($0)
                block(result)
            }
        } else {
            (from...9).forEach {
                var result = base
                result.append($0)
                with(base: result, more: more - 1, block: block)
            }
        }
    }
}
