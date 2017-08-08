/*
 338. Counting Bits
 https://leetcode.com/problems/counting-bits/#/description
 
 Given a non negative integer number num. For every numbers i in the range 0 ≤ i ≤ num calculate the number of 1's in their binary representation and return them as an array.
 
 Example:
 For num = 5 you should return [0,1,1,2,1,2].
 
 Follow up:
 
 It is very easy to come up with a solution with run time O(n*sizeof(integer)). But can you do it in linear time O(n) /possibly in a single pass?
 Space complexity should be O(n).
 Can you do it like a boss? Do it without using any builtin function like __builtin_popcount in c++ or in any other language.
 
 */

// O(n*num)
class Solution {
    func countBits(_ num: Int) -> [Int] {
        var result = [Int]()
        for i in 0...num {
            var i = i
            var count = 0
            while i != 0 {
                if i % 2 == 1 {
                    count += 1
                }
                i = i / 2
            }
            result.append(count)
        }
        return result
    }
}

// O(n)
// An easy recurrence for this problem is f[i] = f[i / 2] + i % 2.
class Solution1 {
    func countBits(_ num: Int) -> [Int] {
        var result = Array<Int>(repeating: 0, count: num+1)
        for i in 0...num {
            result[i] = result[i>>1] + (i&1)
        }
        return result
    }
}

Solution1().countBits(5)
