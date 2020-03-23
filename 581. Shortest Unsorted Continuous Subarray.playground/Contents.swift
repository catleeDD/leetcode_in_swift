import UIKit

// 581. Shortest Unsorted Continuous Subarray
// https://leetcode-cn.com/problems/shortest-unsorted-continuous-subarray/

// 排序算法，自己想的 时间Ologn 空间O（n)
class Solution {
    func findUnsortedSubarray(_ nums: [Int]) -> Int {
        
        let sorted = nums.sorted()
        var i=0,j=nums.count-1
        while i<=j {
            if nums[i]==sorted[i] {
                i += 1
            } else if nums[j]==sorted[j] {
                j -= 1
            } else {
                break
            }
        }
        return j-i+1
        
    }
}

//[2, 6, 4, 8, 10, 9, 15] -> [6, 4, 8, 10, 9]

//[2, 6, 7, 4, 8, 10, 9, 15] -> [6, 7, 4, 8, 10, 9]

//无序子序列的min和max
//左边界>min 右边界<max 左边界-1<=min  右边界+1>=max


// 后面是看答案 https://leetcode-cn.com/problems/shortest-unsorted-continuous-subarray/solution/zui-duan-wu-xu-lian-xu-zi-shu-zu-by-leetcode/
// 栈和更好暴力解法都不好理解
// 以下方法很好理解，也应该想到才对
// 其实想办法找到无序子序列中最大和最小值，就能确定边界了，其实我一开始都想到了要找这两个值，但是没想出来怎么找。其实想复杂了，对于最小值，只要从左边开始遇到第一个降序，然后开始找就行了，这样就肯定是最终找到的最短无序子序列的最小值，最大值同理

// 时间On，空间O1
class Solution1 {
    func findUnsortedSubarray(_ nums: [Int]) -> Int {
        var minus = Int.max, maxmum = Int.min
        for i in 0..<nums.count {
            if i > 0 && nums[i]<nums[i-1] {
                for j in i..<nums.count {
                    minus = min(minus, nums[j])
                }
                break
            }
        }
        for i in (0..<nums.count).reversed() {
            if i < nums.count-1 && nums[i]>nums[i+1] {
                for j in 0...i {
                    maxmum = max(maxmum, nums[j])
                }
                break
            }
        }
        minus
        maxmum
        var left = 0, right = nums.count-1
        for i in 0..<nums.count {
            // 找第一个大于minus的数即可
            if nums[i]>minus {
                break
            }
            left += 1
        }
        for i in (0..<nums.count).reversed() {
            if nums[i]<maxmum {
                break
            }
            right -= 1
        }
        
        return right-left<0 ? 0 : (right - left + 1) // 注意全是升序会是负数
    }
}



Solution1().findUnsortedSubarray([2,1])
