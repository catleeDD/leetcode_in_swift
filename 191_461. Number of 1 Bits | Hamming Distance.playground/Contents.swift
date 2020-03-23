import UIKit

// 191. Number of 1 Bits
// https://leetcode-cn.com/problems/number-of-1-bits/

class Solution {
    func hammingWeight(_ n: Int) -> Int {
        var num = 0, n = n
        while n != 0 {
            num += n & 1
            n = n >> 1
        }
        return num
    }
}


// 官方方法二很巧妙，将n和n-1与运算，会将数字最后一个1变成0，当全变成0时结束。也叫 布赖恩·克尼根算法
//  https://leetcode-cn.com/problems/number-of-1-bits/solution/wei-1de-ge-shu-by-leetcode/

class Solution1 {
    func hammingWeight(_ n: Int) -> Int {
        var num = 0, n = n
        while n != 0 {
            num += 1
            n &= n-1
        }
        return num
    }
}


// 461. Hamming Distance
// https://leetcode-cn.com/problems/hamming-distance/
// 先求XOR（相同数运算为0，不同数运算为1），然后找1的个数

func hammingDistance(_ x: Int, _ y: Int) -> Int {
    var n = x ^ y
    var num = 0
    while n != 0 {
        num += 1
        n &= n-1
    }
    return num
}
