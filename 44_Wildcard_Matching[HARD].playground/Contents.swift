/*
 44. Wildcard Matching
 https://leetcode.com/problems/wildcard-matching/description/
 
 Implement wildcard pattern matching with support for '?' and '*'.
 
 '?' Matches any single character.
 '*' Matches any sequence of characters (including the empty sequence).
 
 The matching should cover the entire input string (not partial).
 
 The function prototype should be:
 bool isMatch(const char *s, const char *p)
 
 Some examples:
 isMatch("aa","a") → false
 isMatch("aa","aa") → true
 isMatch("aaa","aa") → false
 isMatch("aa", "*") → true
 isMatch("aa", "a*") → true
 isMatch("ab", "?*") → true
 isMatch("aab", "c*a*b") → false
 */

// Greedy + Backtracking
class Solution {
    func isMatch(_ s: String, _ p: String) -> Bool {
        var s = Array(s.characters)
        var p = Array(p.characters)
        var iS = 0, iP = 0, backtrackS = 0, iStar = -1;
        while iS < s.count {
            if iP < p.count && (p[iP] == "?".characters.first! || s[iS] == p[iP]) {
                iS += 1
                iP += 1
            }
            // 尝试用*不代替任何字符
            else if iP < p.count && p[iP] == "*".characters.first! {
                iStar = iP
                backtrackS = iS // backtrackS表示s的回溯点，在这之前（包括当前）的字符全都匹配
                iP += 1
            }
            // 如果走不下去，回溯到之前的匹配点，让*多代替一个字符，继续匹配
            else if iStar != -1 {
                // 回溯
                iP = iStar + 1
                iS = backtrackS + 1
                // 此时回溯点要加一，因为在不代替这个字符的情况下已经匹配失败了
                backtrackS += 1
            }
            else {
                return false
            }
        }
        // 剩余全是*才行
        while iP < p.count && p[iP] == "*".characters.first! {
            iP += 1
        }
        
        return iP == p.count
    }
}

// DP
// 1). if(p[j-1]!='*') f(i, j) = f(i-1, j-1) && (s[i-1]==p[j-1] || p[j-1]=='?')
// 2). if(p[j-1]=='*') f(i, j) = f(i, j-1) || f(i-1, j) 
// 解释第二个公式：前面是不用*，后面是用*
// TODO：可以优化成一个数组
// 确实会超时
class Solution1 {
    func isMatch(_ s: String, _ p: String) -> Bool {
        var s = Array(s.characters)
        var p = Array(p.characters)
        let m = s.count
        let n = p.count
        var dp = Array<Array<Bool>>(repeating: Array<Bool>(repeating: false, count: n+1), count: m+1)
        dp[0][0] = true
        if n > 0 {
            for i in 1...n {
                if (p[i - 1] == "*".characters.first!) {
                    dp[0][i] = dp[0][i - 1]
                }
            }
        }
        if m > 0, n > 0 {
            for i in 1...m {
                for j in 1...n {
                    if (p[j - 1] == "*".characters.first!) {
                        dp[i][j] = dp[i - 1][j] || dp[i][j - 1]
                    } else {
                        dp[i][j] = (s[i - 1] == p[j - 1] || p[j - 1] == "?".characters.first!) && dp[i - 1][j - 1]
                    }
                }
            }
        }
        return dp[m][n]
    }
}

