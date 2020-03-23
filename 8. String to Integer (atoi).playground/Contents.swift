import UIKit

//8. String to Integer (atoi)
// https://leetcode-cn.com/problems/string-to-integer-atoi/

// 要注意这两个case，是最难的
//"+-2" => "0"
//"0-2" => "0"

class Solution {
    func myAtoi(_ str: String) -> Int {
        var ret = 0
        var reachFirst = false //到第一个有效字符
        var goFirst = false //第一个有效字符刚过去
        var sign = 1
        let map = ["0":0, "1":1, "2":2, "3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9] //如果是C，可以使用'1'-'0'=1
        for c in str {
            let c = String(c)
            if !reachFirst && c == " " {
                continue
            }
            reachFirst = true
            if !goFirst {
                goFirst = true
                if  c == "-" || c == "+" {
                    sign = c == "-" ? -1 : 1
                    continue
                }
            }
            if !map.keys.contains(c) {
                break
            }
            let x = map[c]! * sign // 这里注意正负
            if (ret<Int32.min/10 || ret==Int32.min/10 && x < -8) {
                ret = Int(Int32.min)
                break
            }
            if (ret>Int32.max/10 || ret==Int32.max/10 && x>7) {
                ret = Int(Int32.max)
                break
            }
            ret = 10 * ret + x
        }
        return ret
    }
}


//"   -42"
//"   +42"
//"+-2" => "0"
//"0-2" => "0"
//"4193 with words"
//"words and 987"
//"-91283472332"


// 也可以不用一开始就循环，可以减少一些变量
class Solution2 {
    func myAtoi(_ str: String) -> Int {
        var ret = 0
        var sign = 1
        let map = ["0":0, "1":1, "2":2, "3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9] //如果是C，可以使用'1'-'0'=1
        var i=0,n = str.count
        let str = Array(str)
        while i<n && str[i] == " " {
            i+=1
        }
        if i<n && (str[i] == "-" || str[i] == "+") {
            sign = str[i] == "-" ? -1 : 1
            i+=1
        }
        
        for i in i..<n {
            let c = String(str[i])
            if !map.keys.contains(c) {
                break
            }
            let x = map[c]! * sign // 这里注意正负
            if (ret<Int32.min/10 || ret==Int32.min/10 && x < -8) {
                ret = Int(Int32.min)
                break
            }
            if (ret>Int32.max/10 || ret==Int32.max/10 && x>7) {
                ret = Int(Int32.max)
                break
            }
            ret = 10 * ret + x
        }
        return ret
    }
}


let s = Solution2()
s.myAtoi("   +-1")

Int32.max
Int32.min

