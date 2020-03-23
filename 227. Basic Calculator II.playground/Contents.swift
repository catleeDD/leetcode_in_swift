import UIKit

// 227. Basic Calculator II

// https://leetcode-cn.com/problems/basic-calculator-ii/


// 自己本来的想法是正确的，用一个栈储存数字，遇到乘除就pop然后算法push，遇到加减就用另一个栈存起来符号，等遍历完一遍后只剩加减，再遍历一遍
// 看了答案后https://leetcode-cn.com/problems/basic-calculator-ii/solution/chai-jie-fu-za-wen-ti-shi-xian-yi-ge-wan-zheng-ji-/ 发现可以直接把加减当做正负号来作为数字一部分，这样就都变成加法了。其实复杂度一样
class Solution {
    func calculate(_ s: String) -> Int {
        let map = ["0":0, "1":1, "2":2, "3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9] //如果是C，可以使用'1'-'0'=1
        var stack = [Int]()
        var num = 0
        var sign = 1
        var needMuti = false
        var needDevide = false
        for c in s {
            if c == " "  {
                continue
            }
            if let v = map[String(c)] {
                num = num*10+v
                continue
            }
            if needMuti {
                stack.append(stack.popLast()! * num)
                needMuti = false
            } else if needDevide {
                stack.append(stack.popLast()! / num)
                needDevide = false
            } else {
                stack.append(num*sign)
                sign = 1
            }
            num = 0
            
            switch c {
            case "+":
                sign = 1
            case "-":
                sign = -1
            case "*":
                needMuti = true
            case "/":
                needDevide = true
            default:
                break
            }
        }
        
        if needMuti {
            stack.append(stack.popLast()! * num)
            
        } else if needDevide {
            stack.append(stack.popLast()! / num)
            
        } else {
            stack.append(num*sign)
            
        }
        var ret = 0
        while !stack.isEmpty {
            ret += stack.popLast()!
        }
        
        return ret
    }
    
}


// 看答案后代码结构优化，把符号记录下来，下次判断
class Solution1 {
    func calculate(_ s: String) -> Int {
        let map = ["0":0, "1":1, "2":2, "3":3,"4":4,"5":5,"6":6,"7":7,"8":8,"9":9] //如果是C，可以使用'1'-'0'=1
        let s = Array(s)
        var stack = [Int]()
        var num = 0
        var sign = "+"
        for i in 0..<s.count {
            let c = String(s[i])
            if c == " "  {
                continue
            }
            if let v = map[c] {
                num = num*10+v
                continue
            }
            
            switch sign {
            case "+":
                stack.append(num)
            case "-":
                stack.append(num * -1)
            case "*":
                stack.append(stack.popLast()! * num)
            case "/":
                stack.append(stack.popLast()! / num)
            default:
                break
            }
            sign = c
            num = 0
        }
        
        switch sign {
        case "+":
            stack.append(num)
        case "-":
            stack.append(num * -1)
        case "*":
            stack.append(stack.popLast()! * num)
        case "/":
            stack.append(stack.popLast()! / num)
        default:
            break
        }
        
        var ret = 0
        while !stack.isEmpty {
            ret += stack.popLast()!
        }
        
        return ret
    }
}

Solution().calculate(" 3+5 / 2 ")
