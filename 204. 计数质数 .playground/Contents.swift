import UIKit

// 204. 计数质数

//https://leetcode-cn.com/problems/count-primes/

// 直接看答案 https://leetcode-cn.com/problems/count-primes/solution/ru-he-gao-xiao-pan-ding-shai-xuan-su-shu-by-labula/
class Solution {
    func countPrimes(_ n: Int) -> Int {
        if n < 3 { return 0 }
        var isPrimes = Array<Bool>(repeating: true, count: n)
        for i in 2 ..< n {
            if isPrimes[i] {
                var j = 2 * i
                while j < n {
                    isPrimes[j] = false
                    j += i
                }
            }
        }
        var count = 0
        for i in 2 ..< n {
            if isPrimes[i] {
                count += 1
            }
        }
        return count
    }
}

// 优化两个循环
class Solution1 {
    func countPrimes(_ n: Int) -> Int {
        if n < 3 { return 0 }
        var isPrimes = Array<Bool>(repeating: true, count: n)
        var i = 2
        while i * i < n { // 第一个优化
            if isPrimes[i] {
                var j = i * i // 第二个优化
                while j < n {
                    isPrimes[j] = false
                    j += i
                }
            }
            i += 1
        }
        var count = 0
        for i in 2 ..< n {
            if isPrimes[i] {
                count += 1
            }
        }
        return count
    }
}

// 可以用BitMap继续优化
