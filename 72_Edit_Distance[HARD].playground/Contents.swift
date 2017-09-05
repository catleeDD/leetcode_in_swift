/*
 72. Edit Distance
 https://leetcode.com/problems/edit-distance/description/
 
 Given two words word1 and word2, find the minimum number of steps required to convert word1 to word2. (each operation is counted as 1 step.)
 
 You have the following 3 operations permitted on a word:
 
 a) Insert a character
 b) Delete a character
 c) Replace a character
 */

class Solution {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let word1 = Array(word1.characters)
        let word2 = Array(word2.characters)
        let m = word1.count
        let n = word2.count
        if m == 0 {
            return n
        }
        if n == 0 {
            return m
        }
        var dp = Array<Array<Int>>(repeating: Array<Int>(repeating: 0, count: n+1), count: m+1)
        for i in 1...m {
            dp[i][0] = i
        }
        for j in 1...n {
            dp[0][j] = j
        }
        for i in 1...m {
            for j in 1...n {
                if word1[i-1] == word2[j-1] {
                    dp[i][j] = dp[i-1][j-1]
                } else {
                    dp[i][j] = min(dp[i-1][j-1], dp[i][j-1], dp[i-1][j]) + 1
                }
            }
        }
        return dp[m][n]
    }
}

// two rows

// one row
class Solution1 {
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let word1 = Array(word1.characters)
        let word2 = Array(word2.characters)
        let m = word1.count
        let n = word2.count
        if m == 0 {
            return n
        }
        if n == 0 {
            return m
        }
        // 每次更新当前row会以上一个row为基准
        var curRow = Array<Int>(repeating: 0, count: n+1)
        for j in 1...n {
            curRow[j] = j
        }
        for i in 1...m {
            // pre就是当前row的当前item的前一个
            var pre = i
            for j in 1...n {
                var cur: Int
                if word1[i-1] == word2[j-1] {
                    cur = curRow[j-1]
                } else {
                    cur = min(curRow[j-1], pre, curRow[j]) + 1
                }
                // 可以更新之前的item因为这个在下次循环中不会用到，但是不能更新curRow[j]因为这个下次还会用到，所以这才是用pre的目的
                curRow[j-1] = pre
                pre = cur
            }
            // 不要忘了更新最后一个
            curRow[n] = pre
        }
        return curRow[n]
    }
}

//Solution().minDistance("", "")
Solution1().minDistance("abcd", "adc")
