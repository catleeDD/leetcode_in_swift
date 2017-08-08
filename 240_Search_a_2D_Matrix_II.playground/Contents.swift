/*
 240. Search a 2D Matrix II
 
 https://leetcode.com/problems/search-a-2d-matrix-ii/description/
 
 Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:
 
 Integers in each row are sorted in ascending from left to right.
 Integers in each column are sorted in ascending from top to bottom.
 For example,
 
 Consider the following matrix:
 
 [
 [1,   4,  7, 11, 15],
 [2,   5,  8, 12, 19],
 [3,   6,  9, 16, 22],
 [10, 13, 14, 17, 24],
 [18, 21, 23, 26, 30]
 ]
 Given target = 5, return true.
 
 Given target = 20, return false.
 
 */

// 从右上角到左下角走z字 o(m+n)
class Solution {
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard matrix.count > 0, matrix[0].count > 0 else {
            return false
        }
        var row = 0
        var col = matrix[0].count - 1
        while col >= 0, row <= matrix.count - 1 {
            if target == matrix[row][col] {
                return true
            } else if target < matrix[row][col] {
                col -= 1
            } else {
                row += 1
            }
        }
        return false
    }
}

// 还有一种方法，是从上往下一行一行走，只判断前后两个数，如果在范围内则用二分法查找当前行。复杂度为o(mlogn)
