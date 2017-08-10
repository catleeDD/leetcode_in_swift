/*
 279. Perfect Squares
 
 https://leetcode.com/problems/perfect-squares/description/
 
 Given a positive integer n, find the least number of perfect square numbers (for example, 1, 4, 9, 16, ...) which sum to n.
 
 For example, given n = 12, return 3 because 12 = 4 + 4 + 4; given n = 13, return 2 because 13 = 4 + 9.
 */


// 我写的，虽然好理解，但是超时了
class Solution {
    func numSquares(_ n: Int) -> Int {
        guard n > 0 else {
            return 0
        }
        var squares = [Int]()
        var i = 1
        while i*i <= n {
            squares.append(i*i)
            i += 1
        }
        return _numSquares(squares, n)
    }
    
    private func _numSquares(_ squares: [Int], _ n: Int) -> Int {
        var squares = squares
        if n <= 0 {
            return 0
        }
        if squares.count == 0 {
            return Int.max
        }
        if squares.count == 1 {
            return n
        }
        while squares[squares.count-1] > n {
            squares.removeLast()
        }
        return min(_numSquares(squares, n-squares[squares.count-1])+1, _numSquares(Array(squares[0..<squares.count-1]), n))
    }
}

//dp[0] = 0
//dp[1] = dp[0]+1 = 1
//dp[2] = dp[1]+1 = 2
//dp[3] = dp[2]+1 = 3
//dp[4] = Min{ dp[4-1*1]+1, dp[4-2*2]+1 }
//    = Min{ dp[3]+1, dp[0]+1 }
//    = 1
//dp[5] = Min{ dp[5-1*1]+1, dp[5-2*2]+1 }
//    = Min{ dp[4]+1, dp[1]+1 }
//    = 2
//.
//.
//.
//dp[13] = Min{ dp[13-1*1]+1, dp[13-2*2]+1, dp[13-3*3]+1 }
//    = Min{ dp[12]+1, dp[9]+1, dp[4]+1 }
//    = 2
//.
//.
//.
//dp[n] = Min{ dp[n - i*i] + 1 },  n - i*i >=0 && i >= 1
// 之所以刚开始没有想到dp的解法，是因为不知道n其实是很小的。
class Solution1 {
    func numSquares(_ n: Int) -> Int {
        guard n > 0 else {
            return 0
        }
        var dp = Array<Int>(repeating: Int.max, count: n+1)
        dp[0] = 0
        for i in 1..<n+1 {
            var j = 1
            while i - j * j >= 0 {
                dp[i] = min(dp[i], dp[i-j*j]+1)
                j += 1
            }
        }
        return dp[n]
    }
}


// 还有个bfs解法，较难理解

//Solution().numSquares(233)
Solution1().numSquares(4)