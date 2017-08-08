/*
 5. Longest Palindromic Substring
 https://leetcode.com/problems/longest-palindromic-substring/#/description
 
 Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.
 
 Example:
 
 Input: "babad"
 
 Output: "bab"
 
 Note: "aba" is also a valid answer.
 Example:
 
 Input: "cbbd"
 
 Output: "bb"
 
 */

// 遍历一遍，每次向两边扩展，复杂度为O(n^2)
class Solution {
    func longestPalindrome(_ s: String) -> String {
        var start: Int = 0
        var length: Int = 1
        var chars: [Character] = Array(s.characters)
        
        for i in 0..<chars.count {
            let (newStart, newLength) = checkPalindrome(chars, i, i) // odd
            if newLength > length {
                start = newStart
                length = newLength
            }
            let (newStart1, newLength1) = checkPalindrome(chars, i, i+1) // even
            if newLength1 > length {
                start = newStart1
                length = newLength1
            }
        }
        
        return String(chars[start..<start + length])
    }
    
    private func checkPalindrome(_ chars: [Character], _ l: Int, _ r: Int) -> (Int, Int) {
        var l = l
        var r = r
        while l >= 0, r < chars.count, chars[l] == chars[r] {
            l -= 1
            r += 1
        }
        return (l + 1, r - l - 1)
    }
}

// 动态规划
class Solution1 {
    func longestPalindrome(_ s: String) -> String {
        var start: Int = 0
        var length: Int = 1
        var chars: [Character] = Array(s.characters)
        let n = chars.count
        var dp: [[Bool]] = Array<Array<Bool>>(repeating: Array<Bool>(repeating: false, count: n), count: n)
        
        //这个顺序很重要
        for i in (0..<chars.count).reversed() {
            for j in i..<chars.count {
                if i == j {
                    dp[i][j] = true
                } else if i == j - 1 {
                    dp[i][j] = chars[i] == chars[j]
                } else {
                    dp[i][j] = chars[i] == chars[j] && dp[i+1][j-1]
                }
                if dp[i][j] && j - i + 1 > length {
                    start = i
                    length = j - i + 1
                }
            }
        }
        
        return String(chars[start..<start + length])
    }
}


Solution1().longestPalindrome("aaaaaaaaaaaaaaaaaaaa")

// Manacher's Algorithm 马拉车算法 http://www.cnblogs.com/grandyang/p/4475985.html
