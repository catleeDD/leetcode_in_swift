/*
 15. 3Sum
 https://leetcode.com/problems/3sum/#/description
 
 Given an array S of n integers, are there elements a, b, c in S such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.
 
 Note: The solution set must not contain duplicate triplets.
 
 For example, given array S = [-1, 0, 1, 2, -1, -4],
 
 A solution set is:
 [
  [-1, 0, 1],
  [-1, -1, 2]
 ]
 
 */

// 错误解法！！！这种解法暂时不知道怎么去除重复的set，只能先排序
class Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        for i in 0..<nums.count-2 {
            let two = twoSum(Array(nums[(i+1)..<nums.count]), -nums[i])
            if two.count > 0 {
                for t in two {
                    result.append([nums[i], t[0], t[1]])
                }
            }
        }
        return result
    }
    
    private func twoSum(_ nums: [Int], _ n: Int) -> [[Int]] {
        var result = [[Int]]()
        var map: [Int: Int] = [:]
        for i in 0..<nums.count {
            if let j = map[nums[i]] {
                result.append([nums[j], nums[i]])
            } else {
                map[n - nums[i]] = i
            }
        }
        return result
    }
}



Solution().threeSum([-1, 0, 1, 2, -1, -4])


// 正确解法，但是会超时
class Solution1 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        let nums = nums.sorted()
        if nums.count < 3 {
            return result
        }
        for i in 0..<nums.count-2 {
            // skip same set
            if i > 0, nums[i] == nums[i - 1] {
                continue
            }
            let two = twoSumSorted(Array(nums[(i+1)..<nums.count]), -nums[i])
            if two.count > 0 {
                for t in two {
                    result.append([nums[i], t[0], t[1]])
                }
            }
        }
        return result
    }
    
    private func twoSumSorted(_ nums: [Int], _ n: Int) -> [[Int]] {
        var result = [[Int]]()
        var i = 0
        var j = nums.count - 1
        while i < j {
            let sum = nums[i] + nums[j]
            if sum == n {
                result.append([nums[i], nums[j]])
                i += 1
                j -= 1
                // skip same set
                while i < j, nums[i] == nums[i - 1] {
                    i += 1
                }
                while i < j, nums[j] == nums[j + 1] {
                    j -= 1
                }
            } else if sum < n {
                i += 1
            } else {
                j -= 1
            }
        }
        return result
    }
}

// 这个比1减少了函数调用，就不超时了。。。
class Solution2 {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        let nums = nums.sorted()
        if nums.count < 3 {
            return result
        }
        for i in 0..<nums.count-2 {
            // skip same set
            if i > 0, nums[i] == nums[i - 1] {
                continue
            }
            let target = -nums[i]
            var lo = i + 1
            var hi = nums.count - 1
            while lo < hi {
                let sum = nums[lo] + nums[hi]
                if sum == target {
                    result.append([nums[i], nums[lo], nums[hi]])
                    lo += 1
                    hi -= 1
                    // skip same set
                    while lo < hi, nums[lo] == nums[lo - 1] {
                        lo += 1
                    }
                    while i < hi, nums[hi] == nums[hi + 1] {
                        hi -= 1
                    }
                } else if sum < target {
                    lo += 1
                } else {
                    hi -= 1
                }
            }
        }
        return result
    }
}

Solution2().threeSum([-2,0,0,2,2])
