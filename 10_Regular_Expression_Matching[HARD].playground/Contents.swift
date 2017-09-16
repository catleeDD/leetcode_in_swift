/*
 10. Regular Expression Matching
 
 https://leetcode.com/problems/regular-expression-matching/description/
 
 Implement regular expression matching with support for '.' and '*'.
 
 '.' Matches any single character.
 '*' Matches zero or more of the preceding element.
 
 The matching should cover the entire input string (not partial).
 
 The function prototype should be:
 bool isMatch(const char *s, const char *p)
 
 Some examples:
 isMatch("aa","a") → false
 isMatch("aa","aa") → true
 isMatch("aaa","aa") → false
 isMatch("aa", "a*") → true
 isMatch("aa", ".*") → true
 isMatch("ab", ".*") → true
 isMatch("aab", "c*a*b") → true
 */

// https://discuss.leetcode.com/topic/6183/my-concise-recursive-and-dp-solutions-with-full-explanation-in-c
// Swift 会超时
class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        var s = Array(s.characters)
        var p = Array(p.characters)
        if p.isEmpty {
            return s.isEmpty
        }
        // 当p的第二个字符为*号时，由于*号前面的字符的个数可以任意，可以为0，那么我们先用递归来调用为0的情况，就是直接把这两个字符去掉再比较，或者当s不为空，且第一个字符和p的第一个字符相同时，我们再对去掉首字符的s和p调用递归，注意p不能去掉首字符，因为*号前面的字符可以有无限个
        if p.count > 1, p[1] == "*".characters.first! {
            return isMatch(String(s), String(p[2..<p.count])) || (!s.isEmpty && (s[0] == p[0] || p[0] == ".".characters.first!) && isMatch(String(s[1..<s.count]), String(p)))
        } else {
            // 如果第二个字符不为*号，那么我们就老老实实的比较第一个字符，然后对后面的字符串调用递归
            return !s.isEmpty && (s[0] == p[0] || p[0] == ".".characters.first!) && isMatch(String(s[1..<s.count]), String(p[1..<p.count]))
        }
    }
}

// DP
// 1.  P[i][j] = P[i - 1][j - 1], if p[j - 1] != '*' && (s[i - 1] == p[j - 1] || p[j - 1] == '.');
// 2.  P[i][j] = P[i][j - 2], if p[j - 1] == '*' and the pattern repeats for 0 times;
// 3.  P[i][j] = P[i - 1][j] && (s[i - 1] == p[j - 2] || p[j - 2] == '.'), if p[j - 1] == '*' and the pattern repeats for at least 1 times.

class Solution1 {
    func isMatch(_ s: String, _ p: String) -> Bool {
        var s = Array(s.characters)
        var p = Array(p.characters)
        let m = s.count
        let n = p.count
        var dp = Array<Array<Bool>>(repeating: Array<Bool>(repeating: false, count: n+1), count: m+1)
        dp[0][0] = true
        // 先确定边界值
        if m > 0 {
            for i in 1...m {
                dp[i][0] = false
            }
        }
        if n > 0 {
            for j in 1...n {
                dp[0][j] = j > 1 && p[j-1] == "*".characters.first! && dp[0][j-2]
            }
        }
        if m > 0, n > 0 {
            for i in 1...m {
                for j in 1...n {
                    if (p[j - 1] == "*".characters.first!) {
                        // p[0] cannot be '*' so no need to check "j > 1" here
                        dp[i][j] = dp[i][j-2] || ((s[i - 1] == p[j - 2] || p[j - 2] == ".".characters.first!) && dp[i - 1][j])
                    } else {
                        dp[i][j] = (s[i - 1] == p[j - 1] || p[j - 1] == ".".characters.first!) && dp[i - 1][j - 1]
                    }
                }
            }
        }
        return dp[m][n]
    }
}

Solution().isMatch("aa", "a*")
Solution1().isMatch("aa", "a*")
