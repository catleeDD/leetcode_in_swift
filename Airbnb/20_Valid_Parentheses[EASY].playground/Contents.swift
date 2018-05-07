/*
 20. Valid Parentheses
 https://leetcode.com/problems/valid-parentheses/#/description
 
 Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
 
 The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.
 */

class Solution {
    func isValid(_ s: String) -> Bool {
        var stack = [Character]()
        for char in s {
            if char == "(" || char == "{" || char == "[" {
                stack.append(char)
            } else if char == ")" {
                if stack.popLast() != "(" {
                    return false
                }
            } else if char == "}" {
                if stack.popLast() != "{" {
                    return false
                }
            } else {
                if stack.popLast() != "[" {
                    return false
                }
            }
        }
        return stack.isEmpty
    }
}

// 这个答案也是挺奇特的
class Solution1 {
    func isValid(_ s: String) -> Bool {
        var stack = [Character]()
        for char in s {
            if char == "(" {
                stack.append(")")
            } else if char == "[" {
                stack.append("]")
            } else if char == "{" {
                stack.append("}")
            } else {
                if stack.popLast() != char {
                    return false
                }
            }
        }
        return stack.isEmpty
    }
}

// swifty
infix operator <>
func <>(l: Character, r: Character) -> Bool {
    return (l == "(" && r == ")") || (l == "[" && r == "]") || (l == "{" && r == "}")
}
class Solution2 {
    func isValid(_ s: String) -> Bool {
        return s.reduce(into: [Character]()) { (acc, char) in
            if let last = acc.last, last <> char {
                acc.removeLast()
            } else {
                acc.append(char)
            }
            }.count == 0
    }
}


// 字典default用法
var dict = [0:1]
dict[1, default:100] = 1
let value = dict[2, default:2]
dict

// 两种reduce区别和用法
let numbers = [1, 2, 3, 4]
let numberSum = numbers.reduce(0, { result, number in
    result + number
})
let numberSum2 = numbers.reduce(into: 0) { (result, number) in
    result = result + number
}
numberSum2
numberSum

let letters = "abracadabra"
let letterCount = letters.reduce(into: [:]) { counts, letter in
    counts[letter, default: 0] += 1
}
let letterCount2 = letters.reduce([:]) { (counts, letter) in
    //编译器傻逼
    var counts0: [Character: Int] = counts as! [Character : Int]
    counts0[letter, default: 0] += 1
    return counts0
}
letterCount
letterCount2

Solution().isValid("")
Solution1().isValid("")
