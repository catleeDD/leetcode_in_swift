import UIKit

// 202. Happy Number
// https://leetcode-cn.com/problems/happy-number/

// 没有思路，看了答案。
// 方法：使用“快慢指针”思想找出循环：“快指针”每次走两步，“慢指针”每次走一步，当二者相等时，即为一个循环周期。此时，判断是不是因为1引起的循环，是的话就是快乐数，否则不是快乐数。
class Solution {
    func isHappy(_ n: Int) -> Bool {
        
        let happyNum: (Int) -> Int = { n in
            var sum = 0, n = n
            while n != 0 {
                sum += (n % 10) * (n % 10)
                n /= 10
            }
            return sum
        }

        var s = n, f = n
        repeat {
            s = happyNum(s)
            f = happyNum(happyNum(f))
        } while s != f
        return s == 1
    }
}

Solution().isHappy(19)
