/*
 51. N-Queens[HARD]
 https://leetcode.com/problems/n-queens/#/description
 
 The n-queens puzzle is the problem of placing n queens on an n×n chessboard such that no two queens attack each other.
 
 
 
 Given an integer n, return all distinct solutions to the n-queens puzzle.
 
 Each solution contains a distinct board configuration of the n-queens' placement, where 'Q' and '.' both indicate a queen and an empty space respectively.
 
 For example,
 There exist two distinct solutions to the 4-queens puzzle:
 
 [
 [".Q..",  // Solution 1
 "...Q",
 "Q...",
 "..Q."],
 
 ["..Q.",  // Solution 2
 "Q...",
 "...Q",
 ".Q.."]
 ]
 
 */


class Solution {
    var result = [[(Int, Int)]]()
    
    func solveNQueens(_ n: Int) -> [[String]] {
        var queens = [(Int, Int)]()
        check(&queens, n)
        return toString()
    }
    
    private func check(_ queens: inout [(Int, Int)], _ n: Int) {
        if queens.count == n {
            result.append(queens)
        } else {
            for col in 0..<n {
                if isValid(queens, p: (queens.count, col)) {
                    queens.append((queens.count, col))
                    check(&queens, n)
                    queens.removeLast()
                }
            }
        }
    }
    
    private func isValid(_ queens: [(Int, Int)], p: (Int, Int)) -> Bool {
        for queen in queens {
            if queen.0 == p.0 || queen.1 == p.1 || queen.0 - queen.1 == p.0 - p.1 || queen.0 + queen.1 == p.0 + p.1 {
                return false
            }
        }
        return true
    }
    
    let Q = "Q".characters.first!
    let Dot = ".".characters.first!
    
    func toString() -> [[String]] {
        var strings = [[String]]()
        for r in result {
            var chars = Array<Array<Character>>(repeating: Array<Character>(repeating: Dot, count: r.count), count: r.count)
            for point in r {
                chars[point.0][point.1] = Q
            }
            strings.append(chars.map { String($0) })
        }
        return strings
    }
}


// 改成经典解法，直接用棋盘记录而不是用一个数组
// 其实这个算法貌似没有我写的效率高，isValid中循环太多，可以用map来解决
class Solution1 {
    let Q = "Q".characters.first!
    let Dot = ".".characters.first!
    var result = [[[Character]]]()
    
    func solveNQueens(_ n: Int) -> [[String]] {
        var queens = Array<Array<Character>>(repeating: Array<Character>(repeating: Dot, count: n), count: n)
        check(&queens, 0, n)
        return toString()
    }
    
    private func check(_ queens: inout [[Character]], _ currentRow: Int, _ n: Int) {
        if currentRow == n {
            result.append(queens)
        } else {
            for col in 0..<n {
                if isValid(queens, currentRow, col, n) {
                    queens[currentRow][col] = Q
                    check(&queens, currentRow + 1, n)
                    queens[currentRow][col] = Dot
                }
            }
        }
    }
    
    private func isValid(_ queens: [[Character]], _ row: Int, _ col: Int, _ n: Int) -> Bool {
        //check if the column had a queen before.
        for i in 0..<row {
            if queens[i][col] == Q {
                return false
            }
        }
        //check if the 45° diagonal had a queen before.
        var i = row - 1
        var j = col - 1
        while i >= 0, j >= 0 {
            if queens[i][j] == Q {
                return false
            }
            i -= 1
            j -= 1
        }
    
        //check if the 135° diagonal had a queen before.
        i = row - 1
        j = col + 1
        while i >= 0, j < n {
            if queens[i][j] == Q {
                return false
            }
            i -= 1
            j += 1
        }
    
        return true
    }
    
    func toString() -> [[String]] {
        var strings = [[String]]()
        for r in result {
            strings.append(r.map { String($0) })
        }
        return strings
    }
}

/*    | | |                / / /             \ \ \
 *    O O O               O O O               O O O
 *    | | |              / / / /             \ \ \ \
 *    O O O               O O O               O O O
 *    | | |              / / / /             \ \ \ \
 *    O O O               O O O               O O O
 *    | | |              / / /                 \ \ \
 *   3 columns        5 45° diagonals     5 135° diagonals    (when n is 3)
 */
// 用map记录
class Solution2 {
    let Q = "Q".characters.first!
    let Dot = ".".characters.first!
    var result = [[[Character]]]()
    
    func solveNQueens(_ n: Int) -> [[String]] {
        var queens = Array<Array<Character>>(repeating: Array<Character>(repeating: Dot, count: n), count: n)
        var mapCol = Array<Bool>(repeating: true, count: n)
        var map45 = Array<Bool>(repeating: true, count: 2*n-1)
        var map135 = Array<Bool>(repeating: true, count: 2*n-1)
        check(&queens, &mapCol, &map45, &map135, 0, n)
        return toString()
    }
    
    private func check(_ queens: inout [[Character]], _ mapCol: inout [Bool], _ map45: inout [Bool], _ map135: inout [Bool], _ currentRow: Int, _ n: Int) {
        if currentRow == n {
            result.append(queens)
        } else {
            for col in 0..<n {
                if mapCol[col], map45[currentRow+col], map135[n-1+col-currentRow] {
                    mapCol[col] = false
                    map45[currentRow+col] = false
                    map135[n-1+col-currentRow] = false
                    queens[currentRow][col] = Q
                    check(&queens, &mapCol, &map45, &map135, currentRow + 1, n)
                    queens[currentRow][col] = Dot
                    mapCol[col] = true
                    map45[currentRow+col] = true
                    map135[n-1+col-currentRow] = true
                }
            }
        }
    }
    
    func toString() -> [[String]] {
        var strings = [[String]]()
        for r in result {
            strings.append(r.map { String($0) })
        }
        return strings
    }
}

//Solution().toString([[(0,1),(1,3),(2,0),(3,2)]])
Solution().solveNQueens(4).count
Solution1().solveNQueens(4).count
Solution2().solveNQueens(4).count

