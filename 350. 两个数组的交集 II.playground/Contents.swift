import UIKit

// https://leetcode-cn.com/problems/intersection-of-two-arrays-ii/


// 优化点，可以将较小的数组存到map中以节省空间
class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let m = nums1.count , n = nums2.count
        var map = [Int:Int]()
        let short = m>n ? nums2 : nums1
        let long = m>n ? nums1 : nums2
        var ret = [Int]()
        for num in short {
            if map[num] != nil {
                map[num]! += 1
            } else {
                map[num] = 1
            }
        }
        for num in long {
            if map.keys.contains(num) {
                ret.append(num)
                map[num]! -= 1
                if map[num]! == 0 {
                    map[num] = nil
                }
            }
        }
        return ret
    }
}


