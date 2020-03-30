import UIKit

//268. Missing Number
//https://leetcode-cn.com/problems/missing-number/


class Solution {
    func missingNumber(_ nums: [Int]) -> Int {
        let n = Double(nums.count)
        var sum = (n+1) * n / 2.0
        for i in nums {
            sum -= Double(i)
        }
        return Int(sum)
    }
}

// 由于异或运算（XOR）满足结合律，并且对一个数进行两次完全相同的异或运算会得到原来的数，因此我们可以通过异或运算找到缺失的数字。
//我们知道数组中有 nn 个数，并且缺失的数在 [0..n][0..n] 中。因此我们可以先得到 [0..n][0..n] 的异或值，再将结果对数组中的每一个数进行一次异或运算。未缺失的数在 [0..n][0..n] 和数组中各出现一次，因此异或后得到 0。而缺失的数字只在 [0..n][0..n] 中出现了一次，在数组中没有出现，因此最终的异或结果即为这个缺失的数字。

class Solution1 {
    func missingNumber(_ nums: [Int]) -> Int {
        var missing = nums.count
        for i in 0..<nums.count {
            missing ^= i ^ nums[i]
        }
        return missing
    }
}
