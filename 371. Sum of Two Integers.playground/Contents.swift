import UIKit

// 371. Sum of Two Integers
// https://leetcode-cn.com/problems/sum-of-two-integers/


//https://leetcode-cn.com/problems/sum-of-two-integers/solution/wei-yun-suan-xiang-jie-yi-ji-zai-python-zhong-xu-y/
// 直接看答案吧
class Solution {
    func getSum(_ a: Int, _ b: Int) -> Int {
        var a = a, b = b
        while b != 0 {
            let lower = a ^ b
            let carrier = (a & b) << 1
            a = lower
            b = carrier
        }
        return a
    }
}
