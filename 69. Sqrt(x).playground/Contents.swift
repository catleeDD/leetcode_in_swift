import UIKit

// 69. Sqrt(x)

// https://leetcode-cn.com/problems/sqrtx/

// 复杂度O(n)
class Solution {
    func mySqrt(_ x: Int) -> Int {
        for i in 0...x {
            if i * i == x { return i }
            if i * i > x { return i - 1 }
        }
        return 0
    }
}

// https://leetcode-cn.com/problems/sqrtx/solution/x-de-ping-fang-gen-by-leetcode/
//  主要是二分查找和牛顿法，后者涉及到高数知识就不展开了，面试时候主要得想出二分查找
//  二分法得注意各种边界情况
// 复杂度Ologn
// 0->0 1->1 2->1 3->1 4->2 5->2 8->2 10->3

// https://leetcode-cn.com/problems/sqrtx/solution/er-fen-cha-zhao-niu-dun-fa-python-dai-ma-by-liweiw/
// 参考代码3的二分模板：中位数取右边界，且right-1，left不-1，可以避免死循环
class Solution1 {
    func mySqrt(_ x: Int) -> Int {
        var left = 0, right = x
        while left < right {
            let mid = left + (right - left + 1) >> 1 // 右边界，比如[2,3]->3
            if mid * mid > x {
                right = mid-1
            } else {
                left = mid
            }
        }
        return left
    }
}

Solution1().mySqrt(10)
