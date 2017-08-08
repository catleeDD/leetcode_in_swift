/*
 62. Unique Paths
 https://leetcode.com/problems/unique-paths/#/description
 A robot is located at the top-left corner of a m x n grid (marked 'Start' in the diagram below).
 
 The robot can only move either down or right at any point in time. The robot is trying to reach the bottom-right corner of the grid (marked 'Finish' in the diagram below).
 
 How many possible unique paths are there?
 
 
 Above is a 3 x 7 grid. How many possible unique paths are there?
 
 Note: m and n will be at most 100.
 
 */

// 这种方法每次都要重新计算，time limit
class Solution {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        guard m > 0, n > 0 else {
            return 0
        }
        return _uniquePaths(m, n)
    }
    
    private func _uniquePaths(_ m: Int, _ n: Int) -> Int {
        if m == 1 || n == 1 {
            return 1
        }
        return _uniquePaths(m - 1, n) + _uniquePaths(m, n - 1)
    }
}

Solution().uniquePaths(1, 2)


class Solution1 {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        guard m > 0, n > 0 else {
            return 0
        }
        var map = Array<Array<Int>>(repeating: Array<Int>(repeating: 0, count: n), count: m)
        
        for i in 0..<m {
            map[i][0] = 1
        }
        for i in 0..<n {
            map[0][i] = 1
        }
        for i in 1..<m {
            for j in 1..<n {
                map[i][j] = map[i-1][j] + map[i][j-1]
            }
        }
        return map[m-1][n-1]
    }
}


Solution1().uniquePaths(10, 10)

// 节省空间
//As can be seen, the above solution runs in O(n^2) time and costs O(m*n) space. However, you may have observed that each time when we update path[i][j], we only need path[i - 1][j] (at the same column) and path[i][j - 1] (at the left column). So it is enough to maintain two columns (the current column and the left column) instead of maintaining the full m*n matrix. Now the code can be optimized to have O(min(m, n)) space complexity.
class Solution2 {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        guard m > 0, n > 0 else {
            return 0
        }
        if m > n {
            return uniquePaths(n, m)
        }
        var pre: [Int] = Array<Int>(repeating: 1, count: m)
        var cur: [Int] = Array<Int>(repeating: 1, count: m)

        for j in 1..<n {
            for i in 1..<m {
                cur[i] = cur[i-1] + pre[i]
            }
            (pre, cur) = (cur, pre)
        }
        return pre[m-1]
    }
}

Solution2().uniquePaths(10, 10)

//Further inspecting the above code, we find that keeping two columns is used to recover pre[i], which is just cur[i] before its update. So there is even no need to use two vectors and one is just enough. Now the space is further saved and the code also gets much shorter.

class Solution3 {
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        guard m > 0, n > 0 else {
            return 0
        }
        if m > n {
            return uniquePaths(n, m)
        }
        var cur: [Int] = Array<Int>(repeating: 1, count: m)
        
        for j in 1..<n {
            for i in 1..<m {
                cur[i] = cur[i-1] + cur[i]
            }
        }
        return cur[m-1]
    }
}

Solution3().uniquePaths(10, 10)

//其实还有纯数学解法，先不看了
