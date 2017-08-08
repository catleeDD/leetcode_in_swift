/*
 70. Climbing Stairs
 https://leetcode.com/problems/climbing-stairs/#/description
 
 You are climbing a stair case. It takes n steps to reach to the top.
 
 Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
 
 Note: Given n will be a positive integer.
 */

/*
 no.1: 1
 no.2: 2
 no.3: 1+2=3
 */
class Solution {
    func climbStairs(_ n: Int) -> Int {
        // n1 代表到前一个台阶的ways
        // n2 代表到当前台阶的ways
        if n <= 0 {
            return 0
        }
        if n == 1 {
            return 1
        }
        if n == 2 {
            return 2
        }
        var n1 = 1
        var n2 = 2
        for _ in 2..<n {
            let temp = n1
            n1 = n2
            n2 = temp + n2
        }
        return n2
    }
}

Solution().climbStairs(4)

// fibonacci. 1 1 2 3 5 8... 从第二个数开始就是结果，这里的a和b没有意义，只是为了计算
class Solution1 {
    func climbStairs(_ n: Int) -> Int {
        var a = 1
        var b = 1
        (0..<n).forEach { _ in
            (a, b) = (b, a + b)
        }
        return a
    }
}

Solution1().climbStairs(4)