import UIKit

//  172. 阶乘后的零

// https://leetcode-cn.com/problems/factorial-trailing-zeroes/

// 数学题，直接看答案吧
// https://leetcode-cn.com/problems/factorial-trailing-zeroes/solution/xiang-xi-tong-su-de-si-lu-fen-xi-by-windliang-3/
// https://leetcode-cn.com/problems/factorial-trailing-zeroes/solution/c-shu-xue-xiang-xi-tui-dao-by-zeroac/

class Solution {
    func trailingZeroes(_ n: Int) -> Int {
        var ret = 0, n = n
        while n != 0 {
            ret += n / 5
            n /= 5
        }
        return ret
    }
}
