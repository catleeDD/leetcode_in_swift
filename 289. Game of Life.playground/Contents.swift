import UIKit

// 289. Game of Life

// https://leetcode-cn.com/problems/game-of-life/

class Solution {
    var board: [[Int]] = []
    func gameOfLife(_ board: inout [[Int]]) {
        self.board = board
        // 0->1 2
        // 1->0 3
        for i in 0..<board.count {
            for j in 0..<board[0].count {
                let arround = isAlive(i-1,j-1) + isAlive(i-1, j) + isAlive(i-1, j+1) + isAlive(i, j-1) + isAlive(i, j+1) + isAlive(i+1, j-1) + isAlive(i+1, j) + isAlive(i+1, j+1)
                if arround < 2 || arround > 3 {
                    // go dead
                    board[i][j] = (board[i][j] == 1) ? 3 : 0
                } else if arround == 3 {
                    // go alive
                    board[i][j] = (board[i][j] == 0) ? 2 : 1
                }
            }
        }
        for i in 0..<board.count {
            for j in 0..<board[0].count {
                if board[i][j] == 2 {
                    board[i][j] = 1
                } else if board[i][j] == 3 {
                    board[i][j] = 0
                }
            }
        }
    }
    func isAlive(_ i: Int, _ j: Int) -> Int {
        if i >= 0 && i <= board.count - 1 && j >= 0 && j <= board[0].count-1 {
            return (board[i][j] == 1 || board[i][j] == 3) ? 1 : 0
        }
        return 0
    }
}


// 可以用一个矩阵小技巧，遍历周围8个的时候，可以将offset变成一个数组，然后遍历，省去手写
// https://leetcode-cn.com/problems/game-of-life/solution/ju-zhen-wen-ti-tong-yong-jie-fa-by-freshrookie/
class Solution1 {
    var board: [[Int]] = []
    func gameOfLife(_ board: inout [[Int]]) {
        self.board = board
        // 0->1 2
        // 1->0 3
        let x = [-1,-1,-1,0,0,1,1,1]
        let y = [-1,0,1,-1,1,-1,0,1]
        
        for i in 0..<board.count {
            for j in 0..<board[0].count {
//                let arround = isAlive(i-1,j-1) + isAlive(i-1, j) + isAlive(i-1, j+1) + isAlive(i, j-1) + isAlive(i, j+1) + isAlive(i+1, j-1) + isAlive(i+1, j) + isAlive(i+1, j+1)
                var arround = 0
                for k in 0..<x.count {
                    arround += isAlive(i+x[k], j+y[k])
                }
                if arround < 2 || arround > 3 {
                    // go dead
                    board[i][j] = (board[i][j] == 1) ? 3 : 0
                } else if arround == 3 {
                    // go alive
                    board[i][j] = (board[i][j] == 0) ? 2 : 1
                }
            }
        }
        for i in 0..<board.count {
            for j in 0..<board[0].count {
                if board[i][j] == 2 {
                    board[i][j] = 1
                } else if board[i][j] == 3 {
                    board[i][j] = 0
                }
            }
        }
    }
    func isAlive(_ i: Int, _ j: Int) -> Int {
        if i >= 0 && i <= board.count - 1 && j >= 0 && j <= board[0].count-1 {
            return (board[i][j] == 1 || board[i][j] == 3) ? 1 : 0
        }
        return 0
    }
}
