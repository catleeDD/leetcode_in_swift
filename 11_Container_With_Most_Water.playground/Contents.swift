/*
 11. Container With Most Water
 https://leetcode.com/problems/container-with-most-water/#/description
 Given n non-negative integers a1, a2, ..., an, where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
 
 Note: You may not slant the container and n is at least 2.
 
 */

class Solution {
    func maxArea(_ height: [Int]) -> Int {
        var i = 0, j = height.count - 1
        var maxA = 0
        while i < j {
            maxA = max(maxA, min(height[i], height[j]) * (j - i))
            if height[i] < height[j] {
                i += 1
            } else {
                j -= 1
            }
        }
        return maxA
    }
}

// 优化 少计算几次面积
class Solution1 {
    func maxArea(_ height: [Int]) -> Int {
        var i = 0, j = height.count - 1
        var maxA = 0
        while i < j {
            let h = min(height[i], height[j])
            maxA = max(maxA, h * (j - i))
            if height[i] < height[j] {
                while height[i] <= h, i < j {
                    i += 1
                }
            } else {
                while height[j] <= h, i < j {
                    j -= 1
                }
            }
        }
        return maxA
    }
}