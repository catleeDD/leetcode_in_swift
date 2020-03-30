import UIKit

// 38. Count and Say

// https://leetcode-cn.com/problems/count-and-say/

// 这题实在没啥意思
class Solution {
    func countAndSay(_ n: Int) -> String {
        if n == 0 { return "" }
        if n == 1 { return "1" }
        if n == 2 { return "11" }
        let str = Array(countAndSay(n-1))
        var ret = ""
        var num = Int(String(str[0]))!
        var freq = 1
        for i in 1..<str.count {
            let val = Int(String(str[i]))!
            if val == num {
                freq += 1
            } else {
                ret += "\(freq)" + "\(num)"
                num = val
                freq = 1
            }
        }
        // 注意最后这个不要写在循环里比较方便
        ret += "\(freq)" + "\(num)"
        return ret
    }
}

Solution().countAndSay(5)
