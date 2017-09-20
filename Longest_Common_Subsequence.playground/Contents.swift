/*
 Longest Common Subsequence
 
 http://www.lintcode.com/en/problem/longest-common-subsequence/
 
 Given two strings, find the longest comment subsequence (LCS).
 Your code should return the length of LCS.
 Example For "ABCD" and "EDCA", the LCS is "A" (or D or C), return 1
 For "ABCD" and "EACB", the LCS is "AC", return 2
 
 */

// http://www.geeksforgeeks.org/longest-common-subsequence/
// 递归，计算次数多
class Solution {
    func longestCommonSubsequence(_ a: String, _ b: String) -> Int {
        let a = Array(a.characters)
        let b = Array(b.characters)
        return lcs(a, b, a.count, b.count)
    }
    
    func lcs(_ a: [Character], _ b: [Character], _ m: Int, _ n: Int) -> Int {
        if (m == 0 || n == 0) {
            return 0
        }
        if a[m-1] == b[n-1] {
            return 1 + lcs(a, b, m-1, n-1)
        } else {
            return max(lcs(a, b, m, n-1), lcs(a, b, m-1, n));
        }
    }
}

// dp，记录中间结果，是递归的优化
class Solution1 {
    func longestCommonSubsequence(_ a: String, _ b: String) -> Int {
        var a = Array(a.characters)
        var b = Array(b.characters)
        if a.count == 0 || b.count == 0 {
            return 0
        }
        var ret = 0
        var dp = Array<Array<Int>>(repeating: Array<Int>(repeating: 0, count: b.count+1), count: a.count+1)
        for i in 1...a.count {
            for j in 1...b.count {
                if a[i-1] == b[j-1] {
                    dp[i][j] = dp[i-1][j-1] + 1
                } else {
                    dp[i][j] = max(dp[i-1][j], dp[i][j-1])
                }
                ret = max(ret, dp[i][j])
            }
        }
        return ret
    }
}

Solution().longestCommonSubsequence("abc", "abec")
Solution().longestCommonSubsequence("", "d")

