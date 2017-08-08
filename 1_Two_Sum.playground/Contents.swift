/*
 1. Two Sum
 https://leetcode.com/problemset/all/?search=two
 
 Given an array of integers, return indices of the two numbers such that they add up to a specific target.
 
 You may assume that each input would have exactly one solution, and you may not use the same element twice.
 
 Example:
 Given nums = [2, 7, 11, 15], target = 9,
 
 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 
 */


/*
 There are a variety of solutions to this problem (some better than others). The following solutions both run in O(n) time.
 */

// 暴力算法
func twoSumProblem(_ a:[Int], key: Int) -> (Int, Int)? {
    for i in 0..<Int(a.count) {
        for j in 0..<Int(a.count) {
            if a[i] + a[j] == key {
                return (i, j)
            }
        }
    }
    return nil
}

let list = [ 7, 2, 23, 8, -1, 0, 11, 6  ]
let a = twoSumProblem(list, key: 13)

func twoSumProblem_useDict(_ a:[Int], key: Int) -> (Int, Int)? {
    var dict = [Int: Int]()
    for i in 0..<a.count {
        if let newkey = dict[a[i]] {
            return (i, newkey)
        } else {
            dict[key - a[i]] = i
        }
    }
    return nil
}

class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int: Int]()
        for i in 0..<nums.count {
            if let newKey = dict[nums[i]] {
                return [newKey, i]
            } else {
                dict[target - nums[i]] = i
            }
        }
        return []
    }
}

Solution().twoSum([3,2,4], 6)

let b = twoSumProblem_useDict(list, key: 13)

// This particular algorithm requires that the array is sorted, so if the array isn't sorted yet (usually it won't be), you need to sort it first. The time complexity of the algorithm itself is O(n) and, unlike the previous solution, it does not require extra storage. Of course, if you have to sort first, the total time complexity becomes O(n log n). Slightly worse but still quite acceptable.
func twoSumProblem_arraysorted(_ a: [Int], key: Int) -> ((Int, Int))? {
    var i = 0
    var j = a.count - 1
    
    while i < j {
        let sum = a[i] + a[j]
        if sum == key {
            return (i, j)
        } else if sum < key {
            i += 1
        } else {
            j -= 1
        }
    }
    return nil
}

let list_sorted = [2, 3, 4, 4, 7, 8, 9, 10, 12, 14, 21, 22, 100]
let c = twoSumProblem_arraysorted(list_sorted, key: 33)
