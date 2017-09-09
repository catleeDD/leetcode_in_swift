/*
 239. Sliding Window Maximum[HARD]
 https://leetcode.com/problems/sliding-window-maximum/#/description
 
 Given an array nums, there is a sliding window of size k which is moving from the very left of the array to the very right. You can only see the k numbers in the window. Each time the sliding window moves right by one position.
 
 For example,
 Given nums = [1,3,-1,-3,5,3,6,7], and k = 3.
 
 Window position                Max
 ---------------               -----
 [1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7
 Therefore, return the max sliding window as [3,3,5,5,6,7].
 
 Note:
 You may assume k is always valid, ie: 1 ≤ k ≤ input array's size for non-empty array.
 
 Follow up:
 Could you solve it in linear time?
 */

class Solution {
    func maxSlidingWindow(_ nums: [Int], _ k: Int) -> [Int] {
        var deque = [Int]()
        var res = [Int]()
        for i in 0..<nums.count {
            if !deque.isEmpty, deque.first! == i - k {
                deque.removeFirst()
            }
            while !deque.isEmpty, nums[i] >= nums[deque.last!] {
                deque.removeLast()
            }
            deque.append(i)
            if i >= k - 1 {
                res.append(nums[deque.first!])
            }
        }
        return res
    }
}

// 还有一个方法， 太巧妙了想不到
//For Example: A = [2,1,3,4,6,3,8,9,10,12,56], w=4
//
//partition the array in blocks of size w=4. The last block may have less then w.
//2, 1, 3, 4 | 6, 3, 8, 9 | 10, 12, 56|
//
//Traverse the list from start to end and calculate max_so_far. Reset max after each block boundary (of w elements).
//left_max[] = 2, 2, 3, 4 | 6, 6, 8, 9 | 10, 12, 56
//
//Similarly calculate max in future by traversing from end to start.
//right_max[] = 4, 4, 4, 4 | 9, 9, 9, 9 | 56, 56, 56
//
//now, sliding max at each position i in current window, sliding-max(i) = max{right_max(i), left_max(i+w-1)}
//sliding_max = 4, 6, 6, 8, 9, 10, 12, 56

Solution().maxSlidingWindow([1,3,-1,-3,5,3,6,7], 3)
