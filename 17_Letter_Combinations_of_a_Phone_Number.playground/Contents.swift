/*
 
 17. Letter Combinations of a Phone Number
 https://leetcode.com/problems/letter-combinations-of-a-phone-number/#/description
 
 Given a digit string, return all possible letter combinations that the number could represent.
 
 A mapping of digit to letters (just like on the telephone buttons) is given below.
 
 1
 2 abc
 3 def
 4 ghi
 5 jkl
 6 mno
 7 pqrs
 8 tuv
 9 wxyz
 0
 
 Input:Digit string "23"
 Output: ["ad", "ae", "af", "bd", "be", "bf", "cd", "ce", "cf"].
 Note:
 Although the above answer is in lexicographical order, your answer could be in any order you want.
 */

class Solution {
    var result = [[Character]]()
    func letterCombinations(_ digits: String) -> [String] {
        let nums = Array(digits.characters).map { Int(String($0))! }
        if nums.count == 0 {
            return []
        }
        let map = ["", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]
        let chars = nums.map { Array(map[$0].characters) }
        var stack = [Character]()
        dfs(chars, 0, &stack)
        
        return result.map { String($0) }
    }
    
    private func dfs(_ chars: [[Character]], _ index: Int, _ stack: inout [Character]) {
        for c in chars[index] {
            stack.append(c)
            if index == chars.count - 1 {
                result.append(stack)
            } else {
                dfs(chars, index + 1, &stack)
            }
            stack.removeLast()
        }
    }
}

// 网上办法，没有想到，一遍一遍加，每次在上一次基础上加上新的
class Solution1 {
    var result = [[Character]]()
    func letterCombinations(_ digits: String) -> [String] {
        let nums = Array(digits.characters).map { Int(String($0))! }
        if nums.count == 0 {
            return []
        }
        let map = ["", "", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]
        let charss = nums.map { Array(map[$0].characters) }
        result.append([])
        for chars in charss {
            var temp = [[Character]]()
            for c in chars {
                for r in result {
                    var r = r
                    r.append(c)
                    temp.append(r)
                }
            }
            result = temp
        }
        
        return result.map { String($0) }
    }
}

Solution1().letterCombinations("23")
