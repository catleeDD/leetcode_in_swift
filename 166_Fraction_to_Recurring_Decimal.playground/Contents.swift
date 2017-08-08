/*
 166. Fraction to Recurring Decimal
 https://leetcode.com/problems/fraction-to-recurring-decimal/#/description
 
 Given two integers representing the numerator and denominator of a fraction, return the fraction in string format.
 
 If the fractional part is repeating, enclose the repeating part in parentheses.
 
 For example,
 
 Given numerator = 1, denominator = 2, return "0.5".
 Given numerator = 2, denominator = 1, return "2".
 Given numerator = 2, denominator = 3, return "0.(6)".
 
 */


class Solution {
    func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        let n = abs(numerator)
        let d = abs(denominator)
        var result = ""
        
        if (numerator < 0 && denominator > 0) || (numerator > 0 && denominator < 0) {
            result = "-" + result
        }
        
        result += "\(n / d)"
        var next = n % d
        if next == 0 {
            return result
        }
        
        result += "."
        var map = [Int: Int]()
        map[next] = result.characters.count
        while next != 0 {
            next *= 10
            result += "\(next / d)"
            next %= d
            if let index = map[next] {
                result.insert("(", at: result.index(result.startIndex, offsetBy: index))
                result.append(")")
                break
            } else {
                map[next] = result.characters.count
            }
        }
        
        return result
    }
}

Solution().fractionToDecimal(1, 7)
