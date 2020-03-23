import UIKit

// 54. Spiral Matrix

// https://leetcode-cn.com/problems/spiral-matrix/



class Solution {
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var ret = [Int]()
        if matrix.count == 0 {
            return ret
        }
        let row = matrix.count
        let col = matrix[0].count
        let count = (min(row, col) + 1) / 2
        // 一圈一圈遍历，一共count圈
        for i in 0..<count {
            // 这里加判断条件主要是swift不允许..<左边比右边大。但是对于只有一行或者一列的情况下，i是可能大于col-i的
            if i < col-i {
                for j in i ..< col-i {
                    ret.append(matrix[i][j])
                }
            }
            // 同上
            if i+1 < row-i {
                for j in i+1 ..< row-i {
                    ret.append(matrix[j][col-i-1])
                }
            }

            if row-i-1 != i && i < col-i-1 {
                for j in (i ..< col-i-1).reversed() {
                    ret.append(matrix[row-i-1][j])
                }
            }
            if col-i-1 != i && i+1 < row-i-1 {
                for j in (i+1 ..< row-i-1).reversed() {
                    ret.append(matrix[j][i])
                }
            }
        }
        return ret
    }
}



//var a  = 0
//for i in 1..<0 {
//    a += 1
//}
//a
