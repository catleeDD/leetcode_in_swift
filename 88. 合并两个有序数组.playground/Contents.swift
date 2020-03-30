import UIKit

// https://leetcode-cn.com/problems/merge-sorted-array/


class Solution {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        // var k = m + n - 1
        var m = m-1 , n = n-1
        for k in (0 ..< m + n + 2).reversed() {
            if m >= 0 && n >= 0 {
                if nums1[m] >= nums2[n] {
                    nums1[k] = nums1[m]
                    m -= 1
                } else {
                    nums1[k] = nums2[n]
                    n -= 1
                }
            } else if m >= 0 {
                nums1[k] = nums1[m]
                m -= 1
            } else {
                nums1[k] = nums2[n]
                n -= 1
            }
        }
    }
}

// 优化点：k不用一定到0，当m<0时候，将num2拷贝到num1前就行，当n<0时，就已经结束了

class Solution1 {
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        // var k = m + n - 1
        var m = m-1 , n = n-1
        for k in (0 ..< m + n + 2).reversed() {
            if m >= 0 && n >= 0 {
                if nums1[m] >= nums2[n] {
                    nums1[k] = nums1[m]
                    m -= 1
                } else {
                    nums1[k] = nums2[n]
                    n -= 1
                }
            } else if n >= 0 {
                nums1[k] = nums2[n]
                n -= 1
            } else {
                break
            }
        }
    }
}
