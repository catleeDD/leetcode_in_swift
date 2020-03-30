import UIKit

// 326. 3的幂

// https://leetcode-cn.com/problems/power-of-three/

//  纯数学题，看答案即可 https://leetcode-cn.com/problems/power-of-three/solution/3de-mi-by-leetcode/
// 两种方法（非循环）记住就行

// 方法1 换底：若n是3的幂，那么log3(n)一定是个整数，由换底公式可以的得到log3(n) = log10(n) / log10(3),只需要判断log3(n)是不是整数即可

class Solution {
    func isPowerOfThree(_ n: Int) -> Bool {
        if n < 0 {return false}
        let val = log10(Double(n)) / log10(3)
        // 判断val是否为整数 其实就是val % 1
        return val.truncatingRemainder(dividingBy: 1) < Double.ulpOfOne
    }
}


// 方法2：3^19是Int32中最大的，其余能被它整除
class Solution1 {
    func isPowerOfThree(_ n: Int) -> Bool {
        return n > 0 && Int(pow(Double(3), Double(19))) % n == 0
    }
}

Solution().isPowerOfThree(1162261467)

// 1162261467
Int(pow(Double(3), Double(19)))

Double.ulpOfOne
DBL_EPSILON
Int(10.39)


Int(exactly: 10.01)

