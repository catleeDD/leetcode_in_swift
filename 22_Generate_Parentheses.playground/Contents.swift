/*
 22. Generate Parentheses
 https://leetcode.com/problems/generate-parentheses/#/description
 
 Given n pairs of parentheses, write a function to generate all combinations of well-formed parentheses.
 
 For example, given n = 3, a solution set is:
 
 [
 "((()))",
 "(()())",
 "(())()",
 "()(())",
 "()()()"
 ]
 
 */


class Solution {
    var result = [String]()
    let LP = "(".characters.first!
    let RP = ")".characters.first!
    func generateParenthesis(_ n: Int) -> [String] {
        let lefts = Array<Character>(repeating: LP, count: n)
        let rights = Array<Character>(repeating: RP, count: n)
        helper(lefts, rights, temp: [])
        return result
    }
    
    private func helper(_ lefts: [Character], _ rights: [Character], temp: [Character]) {
        if rights.isEmpty {
            result.append(String(temp))
            return
        }
        var lefts = lefts
        var rights = rights
//        if !lefts.isEmpty, rights.count == lefts.count {
//            temp.append(lefts.removeLast())
//            helper(lefts, rights, temp: temp)
//        } else if lefts.isEmpty {
//            temp.append(rights.removeLast())
//            helper(lefts, rights, temp: temp)
//        } else {
//            temp.append(lefts.removeLast())
//            helper(lefts, rights, temp: temp)
//            lefts.append(LP)
//            temp.removeLast()
//            temp.append(rights.removeLast())
//            helper(lefts, rights, temp: temp)
//        }
        
        // 这样好理解
        if !lefts.isEmpty {
            lefts.removeLast()
            helper(lefts, rights, temp: temp + [LP])
        }
        if rights.count > lefts.count {
            rights.removeLast()
            helper(lefts, rights, temp: temp + [RP])
        }
    }
}

// 可以只记个数就行，因为括号长得都一样
class Solution1 {
    var result = [String]()
    let LP = "(".characters.first!
    let RP = ")".characters.first!
    func generateParenthesis(_ n: Int) -> [String] {
        helper(n, n, n, [])
        return result
    }
    
    private func helper(_ n: Int, _ left: Int, _ right: Int, _ temp: [Character]) {
        if right == 0 {
            result.append(String(temp))
            return
        }
        if left != 0 {
            helper(n, left - 1, right, temp + [LP])
        }
        if right > left {
            helper(n, left, right - 1, temp + [RP])
        }
    }
}

Solution().generateParenthesis(3)
Solution1().generateParenthesis(3)
