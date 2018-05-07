/*
 751. IP to CIDR
 
 https://leetcode.com/problems/ip-to-cidr/description/
 
 Given a start IP address ip and a number of ips we need to cover n, return a representation of the range as a list (of smallest possible length) of CIDR blocks.
 
 A CIDR block is a string consisting of an IP, followed by a slash, and then the prefix length. For example: "123.45.67.89/20". That prefix length "20" represents the number of common prefix bits in the specified range.
 
 Example 1:
 Input: ip = "255.0.0.7", n = 10
 Output: ["255.0.0.7/32","255.0.0.8/29","255.0.0.16/32"]
 Explanation:
 The initial ip address, when converted to binary, looks like this (spaces added for clarity):
 255.0.0.7 -> 11111111 00000000 00000000 00000111
 The address "255.0.0.7/32" specifies all addresses with a common prefix of 32 bits to the given address,
 ie. just this one address.
 
 The address "255.0.0.8/29" specifies all addresses with a common prefix of 29 bits to the given address:
 255.0.0.8 -> 11111111 00000000 00000000 00001000
 Addresses with common prefix of 29 bits are:
 11111111 00000000 00000000 00001000
 11111111 00000000 00000000 00001001
 11111111 00000000 00000000 00001010
 11111111 00000000 00000000 00001011
 11111111 00000000 00000000 00001100
 11111111 00000000 00000000 00001101
 11111111 00000000 00000000 00001110
 11111111 00000000 00000000 00001111
 
 The address "255.0.0.16/32" specifies all addresses with a common prefix of 32 bits to the given address,
 ie. just 11111111 00000000 00000000 00010000.
 
 In total, the answer specifies the range of 10 ips starting with the address 255.0.0.7 .
 
 There were other representations, such as:
 ["255.0.0.7/32","255.0.0.8/30", "255.0.0.12/30", "255.0.0.16/32"],
 but our answer was the shortest possible.
 
 Also note that a representation beginning with say, "255.0.0.7/30" would be incorrect,
 because it includes addresses like 255.0.0.4 = 11111111 00000000 00000000 00000100
 that are outside the specified range.
 Note:
 ip will be a valid IPv4 address.
 Every implied address ip + x (for x < n) will be a valid IPv4 address.
 n will be an integer in the range [1, 1000].
 */


let a = 0b0000000000011110
let b = 0b1111111111100010 //-a
        0b0000000000000010
a & -a //结果是lowbit 就是二进制数低位连续的0加上一个1组成的数
String(-30, radix: 2, uppercase: false)

//255.0.0.7 -> 11111111 00000000 00000000 00000111
let ip = 0b11111111000000000000000000000111


let ips = "255.0.0.8".split(separator: ".")
let ip1 = ips.reduce(0) { result, ip in
    result * 256 + Int(ip)!
}
ip1
String(ip1, radix: 2, uppercase: false)

ip & -ip
(ip+1) & -(ip+1)

// 这题一点也不简单，非常绕，题意不清楚。有个隐藏条件要是连续的地址
// 也不用考虑非法ip地址的情况，因为题目说了Every implied address ip + x (for x < n) will be a valid IPv4 address.
// 这题只是算法简单而已

class Solution {
    func ipToCIDR(_ ip: String, _ n: Int) -> [String] {
        // 把ip转成int表示
        var ip = ip.split(separator: ".").reduce(0) { result, ip in
            result * 256 + Int(ip)!
        }
        var ans = [String]()
        var n = n
        while n > 0 {
            var step = lowbit(ip)
            // 如果step太多就减少，只需要表示n之内的ip就好
            while step > n {
                step /= 2
            }
            ans.append(cidr(ip, step: step))
            ip += step
            n -= step
        }
        return ans
    }
    
    private func ilowbit(_ x: Int) -> Int {
        for i in 0..<32 {
            if x & 1<<i != 0 {
                return i
            }
        }
        return 0
    }
    
    private func lowbit(_ x: Int) -> Int {
        return 1<<ilowbit(x)
//        return x & -x
    }
    
    // 把int表示的ip转成字符串，且算出prefix位数
    private func cidr(_ ip: Int, step: Int) -> String {
        let len = 32 - ilowbit(step)
        return "\(ip>>24&255)" + "." + "\(ip>>16&255)" + "." + "\(ip>>8&255)" + "." + "\(ip&255)" + "/" + "\(len)"
    }
}

Solution().ipToCIDR("255.0.0.7", 10)
Solution().ipToCIDR("255.0.0.7", 6)
Solution().ipToCIDR("255.0.0.7", 5)
