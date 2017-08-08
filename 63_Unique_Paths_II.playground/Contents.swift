/*
63. Unique Paths II
 
https://leetcode.com/problems/unique-paths-ii/#/description
 
 Follow up for "Unique Paths":
 
 Now consider if some obstacles are added to the grids. How many unique paths would there be?
 
 An obstacle and empty space is marked as 1 and 0 respectively in the grid.
 
 For example,
 There is one obstacle in the middle of a 3x3 grid as illustrated below.
 
 [
 [0,0,0],
 [0,1,0],
 [0,0,0]
 ]
 The total number of unique paths is 2.
 
 Note: m and n will be at most 100.
 
 */

class Solution {
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        guard obstacleGrid.count > 0, obstacleGrid[0].count > 0 else {
            return 0
        }
        let m = obstacleGrid.count
        let n = obstacleGrid[0].count
        var map = Array<Array<Int>>(repeating: Array<Int>(repeating: 0, count: n), count: m)
        
        for i in 0..<m {
            if obstacleGrid[i][0] == 1 {
                break
            }
            map[i][0] = 1
        }
        for i in 0..<n {
            if obstacleGrid[0][i] == 1 {
                break
            }
            map[0][i] = 1
        }
        for i in 1..<m {
            for j in 1..<n {
                if obstacleGrid[i][j] == 0 {
                    map[i][j] = map[i-1][j] + map[i][j-1]
                }
            }
        }
        return map[m-1][n-1]
    }
}

class Solution1 {
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        guard obstacleGrid.count > 0, obstacleGrid[0].count > 0 else {
            return 0
        }
        let m = obstacleGrid.count
        let n = obstacleGrid[0].count
        var cur: [Int] = Array<Int>(repeating: 0, count: m)
        cur[0] = 1
        
        for j in 0..<n {
            for i in 0..<m {
                if obstacleGrid[i][j] == 1 {
                    cur[i] = 0
                } else if i > 0 {
                    cur[i] = cur[i-1] + cur[i]
                }
            }
        }
        return cur[m-1]
    }
}

let grid = [
    [0,0,0],
    [0,1,0],
    [0,0,0]
]
Solution().uniquePathsWithObstacles(grid)
Solution1().uniquePathsWithObstacles(grid)
