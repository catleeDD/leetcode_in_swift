import UIKit

//13. Roman to Integer

//https://leetcode-cn.com/problems/roman-to-integer/

// 判断条件太多太容易漏cast
class Solution {
    func romanToInt(_ s: String) -> Int {
        var ret = 0
        let map = ["I": 1, "V":5, "X":10, "L":50, "C":100, "D":500, "M":1000]
        var last = 0
        let s = Array(s)
        for i in 0..<s.count {
            let c = String(s[i])
            if let val = map[c] {
                // 先判断是否是特殊组合
                if last != 0 && (val/last == 5 || val/last == 10) {
                    ret += val - last
                    last = 0
                } else {
                    // 如果不是特殊组合，需要把上一位加上，然后判断是否是特殊组合的前一位，赋值给last（注意最后一位直接加）
                    ret += last
                    last = 0
                    if i != s.count - 1 && (val == 1 || val == 10 || val == 100) {
                        last = val
                    } else {
                        ret += val
                    }
                }
            }
        }
        return ret
    }
}


// 看了答案的算法，太简单了！
// https://leetcode-cn.com/problems/roman-to-integer/solution/yong-shi-9993nei-cun-9873jian-dan-jie-fa-by-donesp/
// 主要思想，只要当前位比上一位大，就说明是特殊组合，上一位就相当于是负数
class Solution1 {
    func romanToInt(_ s: String) -> Int {
        var ret = 0
        let map = ["I": 1, "V":5, "X":10, "L":50, "C":100, "D":500, "M":1000]
        let s = Array(s)
        for i in 1..<s.count {
            let c = map[String(s[i])]!
            let pc = map[String(s[i-1])]!
            ret += c > pc ? -pc : pc
        }
        ret += map[String(s[s.count-1])]!
        return ret
    }
}
