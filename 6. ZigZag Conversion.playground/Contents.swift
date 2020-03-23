import UIKit

// 6. ZigZag Conversion
// https://leetcode-cn.com/problems/zigzag-conversion/

/*

 第一种方法：找规律
想不出来规律，看了答案
 
LEETCODEISHIRING
n=3
L   C   I   R
E T O E S I I G
E   D   H   N

n=4 step=2n-2=6

0     6      12   k*step
1   5 7   11 13   k*step+i  (k+1)*step-i i=1
2 4   8 10   14   k*step+i  (k+1)*step-i i=2
3     9      15   k*step+i  i=3

n=5
0       8
1     7 9     15
2   6   10   14
3 5     11 13
4       12

*/

class Solution {
    func convert(_ s: String, _ numRows: Int) -> String {
        let n = min(numRows, s.count)
        if n < 2 {
            return s
        }
        let step = 2*n-2
        let s = Array(s)
        var ret = ""
        for i in 0..<n {
            if i == 0 || i == n-1 {
                var k = 0
                while k*step < s.count {
                    ret += String(s[k*step+i])
                    k+=1
                }
            } else {
                var k = 0, index = k*step+i, j = 0
                while index < s.count {
                    ret += String(s[index])
                    if j%2==1 {
                        k+=1
                    }
                    index = (j%2==1) ? k*step+i : (k+1)*step-i
                    j+=1
                }
            }
        }
        return ret
    }
}

/*
 第二种方法，使用巧妙的数据结构，这才是正常做法
 */

class Solution2 {
    func convert(_ s: String, _ numRows: Int) -> String {
        let n = min(numRows, s.count)
        if n < 2 {
            return s
        }
        let s = Array(s)
        var rows = [String]()
        (0..<n).forEach { _ in
            rows.append("")
        }
        var curRow = 0, goingDown = false
        for c in s {
            rows[curRow].append(c)
            if curRow==0||curRow==rows.count-1 {
                goingDown = !goingDown
            }
            curRow+=goingDown ? 1 : -1
        }
        return rows.joined()
    }
}


let s=Solution2()
s.convert("LEETCODEISHIRING", 3)

//LCIRETOESIIGEDHN


