/*
 412. Fizz Buzz
 
 https://leetcode.com/problems/fizz-buzz/#/discuss
 Write a program that outputs the string representation of numbers from 1 to n.
 
 But for multiples of three it should output “Fizz” instead of the number and for the multiples of five output “Buzz”. For numbers which are multiples of both three and five output “FizzBuzz”.
 
 Example:
 
 n = 15,
 
 Return:
 [
 "1",
 "2",
 "Fizz",
 "4",
 "Buzz",
 "Fizz",
 "7",
 "8",
 "Fizz",
 "Buzz",
 "11",
 "Fizz",
 "13",
 "14",
 "FizzBuzz"
 ]
 
 */

// 主要是不用%
class Solution {
    func fizzBuzz(_ n: Int) -> [String] {
        var result = [String]()
        var fizz = 0
        var buzz = 0
        for i in 1...n {
            fizz += 1
            buzz += 1
            if fizz == 3 && buzz == 5 {
                result.append("FizzBuzz")
                fizz = 0
                buzz = 0
            } else if fizz == 3 {
                result.append("Fizz")
                fizz = 0
            } else if buzz == 5 {
                result.append("Buzz")
                buzz = 0
            } else {
                result.append("\(i)")
            }
        }
        return result
    }
}

Solution().fizzBuzz(15)