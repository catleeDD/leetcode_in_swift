/*
 287. Find the Duplicate Number
 https://leetcode.com/problems/find-the-duplicate-number/description/
 
 Given an array nums containing n + 1 integers where each integer is between 1 and n (inclusive), prove that at least one duplicate number must exist. Assume that there is only one duplicate number, find the duplicate one.
 
 Note:
 You must not modify the array (assume the array is read only).
 You must use only constant, O(1) extra space.
 Your runtime complexity should be less than O(n2).
 There is only one duplicate number in the array, but it could be repeated more than once.
 */


// https://segmentfault.com/a/1190000003817671

// 二分法
class Solution {
    func findDuplicate(_ nums: [Int]) -> Int {
        var min = 1
        var max = nums.count - 1
        while min < max {
            let mid = min + (max-min) / 2
            var count = 0
            for num in nums {
                if num <= mid {
                    count += 1
                }
            }
            if count > mid {
                max = mid
            } else {
                min = mid + 1
            }
        }
        return min
    }
}

// 映射找环法
class Solution1 {
    func findDuplicate(_ nums: [Int]) -> Int {
        var slow = nums[0]
        var fast = nums[nums[0]]
        while slow != fast {
            slow = nums[slow]
            fast = nums[nums[fast]]
        }
        var head = 0
        while head != slow {
            slow = nums[slow]
            head = nums[head]
        }
        return head
    }
}

Solution().findDuplicate([2,2,1,3])
