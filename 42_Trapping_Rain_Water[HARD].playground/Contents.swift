/*
 42. Trapping Rain Water
 https://leetcode.com/problems/trapping-rain-water/description/
 
 Given n non-negative integers representing an elevation map where the width of each bar is 1, compute how much water it is able to trap after raining.
 
 For example,
 Given [0,1,0,2,1,0,1,3,2,1,2,1], return 6.
 */

// 四种方法 Solution中写的很好

// dp (其实是bruteforce的优化版，空间换时间)
class Solution0 {
    func trap(_ height: [Int]) -> Int {
        // 注意越界
        if height.count < 3 {
            return 0
        }
        var lmax = Array<Int>(repeating: 0, count: height.count)
        var rmax = Array<Int>(repeating: 0, count: height.count)
        var ans = 0
        lmax[0] = height[0]
        for i in 1..<height.count {
            lmax[i] = max(height[i], lmax[i-1])
        }
        rmax[height.count-1] = height[height.count-1]
        for i in (0..<height.count-1).reversed() {
            rmax[i] = max(height[i], rmax[i+1])
        }
        for i in 1..<height.count-1 {
            ans += min(lmax[i], rmax[i]) - height[i]
        }
        return ans
    }
}

Solution0().trap([0,1,0,2,1,0,1,3,2,1,2,1])

// two pointers
class Solution {
    func trap(_ height: [Int]) -> Int {
        var l = 0
        var r = height.count - 1
        var lmax = 0
        var rmax = 0
        var ans = 0
        while l < r {
            if height[l] < height[r] {
//                if height[l] < lmax {
//                    ans += lmax - height[l]
//                } else {
//                    lmax = height[l]
//                }
                let temp = max(height[l], lmax)
                ans += temp - height[l]
                lmax = temp
                l += 1
            } else {
//                if height[r] < rmax {
//                    ans += rmax - height[r]
//                } else {
//                    rmax = height[r]
//                }
                let temp = max(height[r], rmax)
                ans += temp - height[r]
                rmax = temp
                r -= 1
            }
        }
        return ans
    }
}

// stack 一层一层的加，而不是上面的方法一列一列加
// 画图更好理解
class Solution1 {
    func trap(_ height: [Int]) -> Int {
        var current = 0
        var ans = 0
        var stack = [Int]()
        while current < height.count {
            while !stack.isEmpty, height[current] > height[stack[stack.count-1]] {
                let top = stack.popLast()!
                if stack.isEmpty {
                    break
                }
                let left = stack.last!
                let distance = current - left - 1
                let height = min(height[current], height[left]) - height[top]
                ans += height * distance
            }
            stack.append(current)
            current += 1
        }
        return ans
    }
}

Solution1().trap([0,1,0,2,1,0,1,3,2,1,2,1])