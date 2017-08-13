/*
 200. Number of Islands
 
 https://leetcode.com/problems/number-of-islands/description/
 
 Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
 
 Example 1:
 
 11110
 11010
 11000
 00000
 Answer: 1
 
 Example 2:
 
 11000
 11000
 00100
 00011
 Answer: 3
 */

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

class Solution {
    let zero = "0".characters.first!
    let one = "1".characters.first!
    
    func numIslands(_ grid: [[Character]]) -> Int {
        guard grid.count > 0, grid[0].count > 0 else {
            return 0
        }
        let m = grid.count
        let n = grid[0].count
        let uf = UF(m * n)
        
        // 原始0的个数
        var countOfZero = 0
        
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == one {
                    if i > 0, grid[i-1][j] == one {
                        uf.union(i*n+j, (i-1)*n+j)
                    }
                    if i < m-1, grid[i+1][j] == one {
                        uf.union(i*n+j, (i+1)*n+j)
                    }
                    if j > 0, grid[i][j-1] == one {
                        uf.union(i*n+j, i*n+(j-1))
                    }
                    if j < n-1, grid[i][j+1] == one {
                        uf.union(i*n+j, i*n+(j+1))
                    }
                } else {
                    countOfZero += 1
                }
            }
        }
        
        return uf.count()-countOfZero
    }
}

// 如果它的值是1，就把所有与之相邻的1全都改写成0，最后把islands个数加一
class Solution1 {
    let zero = "0".characters.first!
    let one = "1".characters.first!
    
    func numIslands(_ grid: [[Character]]) -> Int {
        guard grid.count > 0, grid[0].count > 0 else {
            return 0
        }
        var grid = grid
        let m = grid.count
        let n = grid[0].count
        var islands = 0
        
        for i in 0..<m {
            for j in 0..<n {
                if grid[i][j] == one {
                    islands += 1
                    dfs(&grid, i, j)
                }
            }
        }
        
        return islands
    }
    
    private func dfs(_ grid: inout [[Character]], _ i: Int, _ j: Int) {
        guard i >= 0, i <= grid.count - 1, j >= 0, j <= grid[0].count - 1, grid[i][j] == one else {
            return
        }
        grid[i][j] = zero
        dfs(&grid, i-1, j)
        dfs(&grid, i+1, j)
        dfs(&grid, i, j-1)
        dfs(&grid, i, j+1)
    }
}

Solution1().numIslands([Array("11110".characters),Array("11010".characters),Array("11000".characters),Array("00000".characters)])