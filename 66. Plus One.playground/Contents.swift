import UIKit

// 66. Plus One
// https://leetcode-cn.com/problems/plus-one/

class Solution {
    func plusOne(_ digits: [Int]) -> [Int] {
        var digits = digits
        var overflow = 0
        for i in (0..<digits.count).reversed() {
            var sum = digits[i]
            if i == digits.count-1 {
                sum+=1
            }
            sum+=overflow
            if sum > 9 {
                overflow = 1
                digits[i] = 0
            } else {
                overflow = 0
                digits[i] = sum
            }
        }
        if overflow == 1 {
            digits.insert(1, at: 0)
        }
        return digits
    }
}

// 优化一下，只要美而有overflow就可以提前结束，而且也不需要判断overflow，只要循环没结束，就一定得+1
func plusOne(_ digits: [Int]) -> [Int] {
    var digits = digits
    for i in (0..<digits.count).reversed() {
        digits[i]+=1
        if digits[i] > 9 {
            digits[i] = 0
        } else {
            return digits
        }
    }
    // 到这里一定全是9
    digits.insert(1, at: 0)
    return digits
}

Solution().plusOne([9,9,9])
