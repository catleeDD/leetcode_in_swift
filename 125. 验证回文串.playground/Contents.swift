import UIKit

// 125. 验证回文串
//https://leetcode-cn.com/problems/valid-palindrome/

class Solution {
    func isPalindrome(_ s: String) -> Bool {
        if s.count < 2 { return true }
        let s = Array(s.lowercased())
        var i = 0, j = s.count-1
        let a = Int("a".unicodeScalars.first!.value)
        let z = Int("z".unicodeScalars.first!.value)
        let zero = Int("0".unicodeScalars.first!.value)
        let nine = Int("9".unicodeScalars.first!.value)
        while i <= j {
            let x = Int(s[i].unicodeScalars.first!.value)
            let y = Int(s[j].unicodeScalars.first!.value)
            if !(a...z).contains(x) && !(zero...nine).contains(x) {
                i += 1
                continue
            }
            if !(a...z).contains(y) && !(zero...nine).contains(y) {
                j -= 1
                continue
            }
            if s[i] == s[j] {
                i += 1
                j -= 1
            } else {
                return false
            }
        }
        return true
    }
}

// 直接使用内置函数判断
class Solution1 {
    func isPalindrome(_ s: String) -> Bool {
        if s.count < 2 { return true }
        let s = Array(s.lowercased())
        var i = 0, j = s.count-1
        while i <= j {
            if !s[i].isLetter && !s[i].isNumber {
                i += 1
                continue
            }
            if !s[j].isLetter && !s[j].isNumber {
                j -= 1
                continue
            }
            if s[i] == s[j] {
                i += 1
                j -= 1
            } else {
                return false
            }
        }
        return true
    }
}

Solution1().isPalindrome("A man, a plan, a canal: Panama")
