/*
 219. Contains Duplicate II
 
 https://leetcode.com/problems/contains-duplicate-ii/description/
 Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array such that nums[i] = nums[j] and the absolute difference between i and j is at most k.
 */

// 超时
class Solution {
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        for i in 0..<nums.count {
            var j = i+1
            while j < nums.count && j - i <= k {
                if nums[j] == nums[i] {
                    return true
                }
                j += 1
            }
        }
        return false
    }
}

// 一般这种涉及相等元素的都可以用hashtable(set)解决
// 其实也是slidewindow问题
class Solution1 {
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        var set = Set<Int>()
        for i in 0..<nums.count {
            if set.count > k {
                set.remove(nums[i-k-1])
            }
            if set.contains(nums[i]) {
                return true
            }
            set.insert(nums[i])
        }
        return false
    }
}

Solution().containsNearbyDuplicate([1,2,3,4,5,1,2,3], 2)
Solution1().containsNearbyDuplicate([1,2,3,4,5,1,2,3], 2)
Solution1().containsNearbyDuplicate([-1,-1], 1)
