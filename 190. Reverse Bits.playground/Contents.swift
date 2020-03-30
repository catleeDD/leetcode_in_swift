import UIKit

// 190. Reverse Bits

// https://leetcode-cn.com/problems/reverse-bits/


class Solution {
    func reverseBits(_ n: Int) -> Int {
        var ret = 0,n = n
        for _ in 0..<32 {
            ret = ret*2 + n&1
            n >>= 1
        }
        return ret
    }
}

Solution().reverseBits(43261596)

