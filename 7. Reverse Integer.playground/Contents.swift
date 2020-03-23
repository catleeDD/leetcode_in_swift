import UIKit

// https://leetcode-cn.com/problems/reverse-integer/


class Solution {
    func reverse(_ x: Int) -> Int {
        // 注意判断范围
        if x < Int32.min || x > Int32.max {
            return 0
        }
        var ret = x, stack = [Int]()
        while ret != 0 {
            stack.append(ret % 10)
            ret /= 10
        }
        var i = 0
        while !stack.isEmpty {
            ret += (powInt(10,i)) * stack.popLast()!
            i += 1
        }
        
        // 注意返回值也要判断范围
        if ret < Int32.min || ret > Int32.max {
            return 0
        }
        return ret
    }
    // swift个坑爹货，power只能用Double，而且只能转Int64
    let powInt:(Int,Int)->Int = {a,b in return Int(pow(Double(a), Double(b)))}
}


// 可以只用一个循环，不用数组
// 比如123，ret的变化为：3，23(3*10+2)，321(32*10+1)
// 确实不好想，比较tricky
class Solution2 {
    func reverse(_ x: Int) -> Int {
        // 注意判断范围
        if x < Int32.min || x > Int32.max {
            return 0
        }
        var x = x
        var ret = 0
        while x != 0 {
            let pop = x % 10
            ret = ret * 10 + pop
            x /= 10
        }

        // 注意返回值也要判断范围
        if ret < Int32.min || ret > Int32.max {
            return 0
        }
        return ret
    }
    // swift个坑爹货，power只能用Double，而且只能转Int64
    let powInt:(Int,Int)->Int = {a,b in return Int(pow(Double(a), Double(b)))}
}

// 判断条件提前 https://leetcode-cn.com/problems/reverse-integer/solution/hua-jie-suan-fa-7-zheng-shu-fan-zhuan-by-guanpengc/
class Solution3 {
    func reverse(_ x: Int) -> Int {
        var x = x
        var ret = 0
        while x != 0 {
            let pop = x % 10
            if (ret > Int32.max / 10 || (ret == Int32.max / 10 && pop > 7)) {
                return 0;
            }
            if (ret < Int32.min / 10 || (ret == Int32.min / 10 && pop < -8)) {
                return 0;
            }
            ret = ret * 10 + pop
            x /= 10
        }

        return ret
    }
}

////123 321
////-123 -321
////120 21
// 1534236469
let s = Solution2()
s.reverse(123)

