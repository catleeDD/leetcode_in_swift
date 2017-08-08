//: Playground - noun: a place where people can play

import UIKit

/*
 130. Surrounded Regions
 https://leetcode.com/problems/surrounded-regions/#/description
 
 Given a 2D board containing 'X' and 'O' (the letter O), capture all regions surrounded by 'X'.
 
 A region is captured by flipping all 'O's into 'X's in that surrounded region.
 
 For example,
 X X X X
 X O O X
 X X O X
 X O X X
 After running your function, the board should be:
 
 X X X X
 X X X X
 X X X X
 X O X X

*/


//Union Find

//BFS

//DFS

//DFS（stack）

class Solution_DFS {
    let X = "X".characters.first!
    let O = "O".characters.first!
    let I = "I".characters.first!
    
    func solve(_ board: inout [[Character]]) {
        // 2是为了防止[O]的情况
        guard board.count > 2, board[0].count > 2 else {
            return
        }
        
        for x in (0..<board.count) {
            if board[x][0] == O {
                dfs(&board, x: x, y: 0)
            }
            if board[x][board[0].count - 1] == O {
                dfs(&board, x: x, y: board[0].count - 1)
            }
        }
        
        for y in (0..<board[0].count) {
            if board[0][y] == O {
                dfs(&board, x: 0, y: y)
            }
            if board[board.count - 1][y] == O {
                dfs(&board, x: board.count - 1, y: y)
            }
        }
        
        for x in (0..<board.count) {
            for y in (0..<board[0].count) {
                if board[x][y] == O {
                    board[x][y] = X
                } else if board[x][y] == I {
                    board[x][y] = O
                }
            }
        }
    }
    
    private func dfs(_ board: inout [[Character]], x: Int, y: Int) {
        guard x >= 0, x <= board.count - 1, y >= 0, y <= board[0].count - 1 else {
            return
        }
        board[x][y] = I
        if x > 1, board[x - 1][y] == O {
            dfs(&board, x: x - 1, y: y)
        }
        if x < board.count - 2, board[x + 1][y] == O {
            dfs(&board, x: x + 1, y: y)
        }
        if y > 1, board[x][y - 1] == O {
            dfs(&board, x: x, y: y - 1)
        }
        if y < board[0].count - 2, board[x][y + 1] == O {
            dfs(&board, x: x, y: y + 1)
        }
    }
}

class Solution_DFS_UseStack {
    let X = "X".characters.first!
    let O = "O".characters.first!
    let I = "I".characters.first!
    
    func solve(_ board: inout [[Character]]) {
        // 2是为了防止[O]的情况
        guard board.count > 2, board[0].count > 2 else {
            return
        }
        
        for x in (0..<board.count) {
            if board[x][0] == O {
                dfs(&board, x: x, y: 0)
            }
            if board[x][board[0].count - 1] == O {
                dfs(&board, x: x, y: board[0].count - 1)
            }
        }
        
        for y in (0..<board[0].count) {
            if board[0][y] == O {
                dfs(&board, x: 0, y: y)
            }
            if board[board.count - 1][y] == O {
                dfs(&board, x: board.count - 1, y: y)
            }
        }
        
        for x in (0..<board.count) {
            for y in (0..<board[0].count) {
                if board[x][y] == O {
                    board[x][y] = X
                } else if board[x][y] == I {
                    board[x][y] = O
                }
            }
        }
    }
    
    private func dfs(_ board: inout [[Character]], x: Int, y: Int) {
        var stack = [(Int, Int)]()
        stack.append((x, y))
        guard x >= 0, x <= board.count - 1, y >= 0, y <= board[0].count - 1 else {
            return
        }
        board[x][y] = I
        while let (x, y) = stack.popLast() {
            if x > 1, board[x - 1][y] == O {
                board[x - 1][y] = I
                stack.append((x - 1, y))
            }
            if x < board.count - 2, board[x + 1][y] == O {
                board[x + 1][y] = I
                stack.append((x + 1, y))
            }
            if y > 1, board[x][y - 1] == O {
                board[x][y - 1] = I
                stack.append((x, y - 1))
            }
            if y < board[0].count - 2, board[x][y + 1] == O {
                board[x][y + 1] = I
                stack.append((x, y + 1))
            }
        }
    }
}


class Solution_BFS {
    let X = "X".characters.first!
    let O = "O".characters.first!
    let I = "I".characters.first!
    
    func solve(_ board: inout [[Character]]) {
        guard board.count > 2, board[0].count > 2 else {
            return
        }
        
        for x in (0..<board.count) {
            if board[x][0] == O {
                bfs(&board, x: x, y: 0)
            }
            if board[x][board[0].count - 1] == O {
                bfs(&board, x: x, y: board[0].count - 1)
            }
        }
        
        for y in (0..<board[0].count) {
            if board[0][y] == O {
                bfs(&board, x: 0, y: y)
            }
            if board[board.count - 1][y] == O {
                bfs(&board, x: board.count - 1, y: y)
            }
        }
        
        for x in (0..<board.count) {
            for y in (0..<board[0].count) {
                if board[x][y] == O {
                    board[x][y] = X
                } else if board[x][y] == I {
                    board[x][y] = O
                }
            }
        }
    }
    
    private func bfs(_ board: inout [[Character]], x: Int, y: Int) {
        var queue = [(Int, Int)]()
        queue.append((x, y))
        board[x][y] = I
        while !queue.isEmpty {
            let (x, y) = queue.removeFirst()
            guard x >= 0, x <= board.count - 1, y >= 0, y <= board[0].count - 1 else {
                return
            }
            if x > 1, board[x - 1][y] == O {
                board[x - 1][y] = I
                queue.append((x - 1, y))
            }
            if x < board.count - 2, board[x + 1][y] == O {
                board[x + 1][y] = I
                queue.append((x + 1, y))
            }
            if y > 1, board[x][y - 1] == O {
                board[x][y - 1] = I
                queue.append((x, y - 1))
            }
            if y < board[0].count - 2, board[x][y + 1] == O {
                board[x][y + 1] = I
                queue.append((x, y + 1))
            }
        }
    }
}


class Solution_UnionFind {
    
    class UF {
        private var ids: [Int] // 父链接数组
        private var sizes: [Int] //各个根节点对应分量大小
        private var _count: Int //连通分量的数量
        
        init(_ n: Int) {
            _count = n
            ids = Array<Int>(repeating: 0, count: n)
            sizes = Array<Int>(repeating: 1, count: n)
            (0..<n).forEach {
                ids[$0] = $0
            }
        }
        
        func count() -> Int {
            return _count
        }
        
        func connected(_ p: Int, _ q: Int) -> Bool {
            return find(p) == find(q)
        }
        
        func find(_ p: Int) -> Int {
            // 跟随父节点找到根节点
            var p = p
            while p != ids[p] {
                p = ids[p]
            }
            return p
        }
        
        func union(_ p: Int, _ q: Int) {
            let i = find(p)
            let j = find(q)
            if i == j {
                return
            }
            // 将小数的根节点连接到大树的根节点
            if sizes[i] < sizes[j] {
                ids[i] = j
                sizes[j] += sizes[i]
            } else {
                ids[j] = i
                sizes[i] += sizes[j]
            }
            _count -= 1
        }
    }
    
    let X = "X".characters.first!
    let O = "O".characters.first!
    
    func solve(_ board: inout [[Character]]) {
        guard board.count > 2, board[0].count > 2 else {
            return
        }
        let n = board.count
        let m = board[0].count
        let uf = UF(n * m + 1)
        for x in (0..<n) {
            for y in (0..<m) {
                if (x == 0 || x == n - 1 || y == 0 || y == m - 1) && board[x][y] == O {
                    // if a 'O' node is on the boundry, connect it to the dummy node
                    uf.union(x*m+y, n*m)
                } else if board[x][y] == O {
                    // connect a 'O' node to its neighbour 'O' nodes
                    if board[x-1][y] == O {
                        uf.union(x*m+y, (x-1)*m+y)
                    }
                    if board[x+1][y] == O {
                        uf.union(x*m+y, (x+1)*m+y)
                    }
                    if board[x][y-1] == O {
                        uf.union(x*m+y, x*m+y-1)
                    }
                    if board[x][y+1] == O {
                        uf.union(x*m+y, x*m+y+1)
                    }
                }
            }
        }
        
        for x in (0..<n) {
            for y in (0..<m) {
                if !uf.connected(x*m+y, n*m) {
                    // if a 'O' node is not connected to the dummy node, it is captured
                    board[x][y] = X
                }
            }
        }
    }
    
}


let X = "X".characters.first!
let O = "O".characters.first!

var a : [[Character]] = [
    [X, X, X, X],
    [X, O, O, X],
    [X, X, O, X],
    [X, O, X, X]
//    [O,O,O],
//    [O,O,O],
//    [O,O,O]
]


Solution_UnionFind().solve(&a)

a






