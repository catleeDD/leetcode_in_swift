/*
 84. Largest Rectangle in Histogram
 https://leetcode.com/problems/largest-rectangle-in-histogram/description/
 
 Given n non-negative integers representing the histogram's bar height where the width of each bar is 1, find the area of largest rectangle in the histogram.
 
 
 Above is a histogram where width of each bar is 1, given height = [2,1,5,6,2,3].
 
 
 The largest rectangle is shown in the shaded area, which has area = 10 unit.
 
 For example,
 Given heights = [2,1,5,6,2,3],
 return 10.
 
 */

//思路：http://www.geeksforgeeks.org/largest-rectangle-under-histogram/
// o(n)
// 这道题跟 42 Trapping Rain Water的stack解法一个思路
// 关键在于找到左边和右边离自己最近的比自己小（大）的点
class Solution {
    func largestRectangleArea(_ heights: [Int]) -> Int {
        var current = 0
        var ans = 0
        var stack = [Int]()
        while current < heights.count {
            while !stack.isEmpty, heights[current] < heights[stack.last!] {
                let top = stack.popLast()!
                let distance = stack.isEmpty ? current : current - stack.last! - 1
                ans = max(ans, heights[top] * distance)
            }
            stack.append(current)
            current += 1
        }
        // 注意
        while !stack.isEmpty {
            let top = stack.popLast()!
            let distance = stack.isEmpty ? current : current - stack.last! - 1
            ans = max(ans, heights[top] * distance)
        }
        return ans
    }
}

// 此题还有个Divide & Conquer的O(nlogn)解法

Solution().largestRectangleArea([1])
Solution().largestRectangleArea([2,1,5,6,2,3])