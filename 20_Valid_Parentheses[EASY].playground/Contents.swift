/*
 20. Valid Parentheses
 https://leetcode.com/problems/valid-parentheses/#/description
 
 Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
 
 The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.
 */

class Solution {
    func isValid(_ s: String) -> Bool {
        let chars = Array(s.characters)
        guard chars.count > 0 else { return false }
        var stack = [Character]()
        for char in chars {
            if char == "(".characters.first! || char == "{".characters.first! || char == "[".characters.first! {
                stack.append(char)
            } else if char == ")".characters.first! {
                if stack.popLast() != "(" {
                    return false
                }
            } else if char == "}".characters.first! {
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
        let chars = Array(s.characters)
        guard chars.count > 0 else { return false }
        var stack = [Character]()
        for char in chars {
            if char == "(".characters.first! {
                stack.append(")".characters.first!)
            } else if char == "[".characters.first! {
                stack.append("]".characters.first!)
            } else if char == "{".characters.first! {
                stack.append("}".characters.first!)
            } else {
                if stack.popLast() != char {
                    return false
                }
            }
        }
        return stack.isEmpty
    }
}


Solution().isValid("((")