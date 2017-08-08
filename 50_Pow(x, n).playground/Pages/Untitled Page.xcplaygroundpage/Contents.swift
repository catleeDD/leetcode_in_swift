/*
 
 50. Pow(x, n)
 https://leetcode.com/problems/powx-n/#/description
 
 */

// 分治
class Solution {
    func myPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 {
            return 1
        }
        let temp = myPow(x, n / 2)
        var result = temp * temp
        if n % 2 != 0 {
            result *= n < 0 ? 1/x : x
        }
        return result
    }
}

Solution().myPow(2, -2)

// 递归
class Solution1 {
    func myPow(_ x: Double, _ n: Int) -> Double {
        var x = x
        var n = n
        if n == 0 {
            return 1
        }
        if n < 0 {
            n = -n
            x = 1/x
        }
        return n % 2 == 0 ? myPow(x*x, n/2) : myPow(x*x, n/2)*x
    }
}

// 循环
class Solution2 {
    func myPow(_ x: Double, _ n: Int) -> Double {
        var x = x
        var n = n
        if n == 0 {
            return 1
        }
        if n < 0 {
            n = -n
            x = 1/x
        }
        var result: Double = 1
        while n > 0 {
            if n % 2 != 0 {
                result *= x
            }
            x *= x
            n /= 2
        }
        return result
    }
}

Solution2().myPow(2, -2)
