/*
 Longest Common Substring
 
 http://www.lintcode.com/en/problem/longest-common-substring/
 Given two strings, find the longest common substring.
 Return the length of it.
 
 Example
 Given A="ABCD", B="CBCE", return 2.
 
 Note The characters in substring should occur continiously in original string. This is different with subsequnce.
 */

// 暴力解法是用O(m^2)算出a的所有substring，然后用O(n)算出是否也是b的substring。总时间是O(mmn)

// two pointers O(m*n*lcs)
class Solution {
    func longestCommonSubstring(_ a: String, _ b: String) -> Int {
        var a = Array(a.characters)
        var b = Array(b.characters)
        var ret = 0
        for i in 0..<a.count {
            for j in 0..<b.count {
                var temp = 0
                while i + temp < a.count, j + temp < b.count, a[i+temp] == b[j+temp] {
                    temp += 1
                }
                ret = max(ret, temp)
            }
        }
        return ret
    }
}

Solution().longestCommonSubstring("ABCD", "CBCE")
Solution().longestCommonSubstring("", "")

// dp O(mn)
// f[i][j] = f[i - 1][j - 1] + 1 or 0
class Solution1 {
    func longestCommonSubstring(_ a: String, _ b: String) -> Int {
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
                }
                ret = max(ret, dp[i][j])
            }
        }
        return ret
    }
}

Solution1().longestCommonSubstring("ABCD", "CBCE")
Solution1().longestCommonSubstring("", "")
