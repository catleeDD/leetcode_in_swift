// http://wiki.jikexueyuan.com/project/kmp-algorithm/violent-match.html

//暴力匹配
//如果当前字符匹配成功（即 S[i] == P[j]），则 i++，j++，继续匹配下一个字符；
//如果失配（即 S[i]! = P[j]），令 i = i - (j - 1)，j = 0。相当于每次匹配失败时，i 回溯，j 被置为0。
func violentMatch(_ s: String, _ p: String) -> Int {
    var s = Array(s.characters)
    var p = Array(p.characters)
    var i = 0, j = 0
    while i < s.count, j < p.count {
        if s[i] == p[j] {
            i += 1
            j += 1
        } else {
            i = i - (j - 1)
            j = 0
        }
    }
    if j == p.count {
        return i - j
    } else {
        return -1
    }
}

violentMatch("baadaaafd", "aaa")

// 若p[k] == p[j]，则 next[j + 1 ] = next [j] + 1 = k + 1；
//若p[k ] ≠ p[j]，如果此时 p[ next[k] ] == p[j ]，则 next[ j + 1 ] = next[k] + 1，否则继续递归前缀索引 k = next[k]，而后重复此过程。 相当于在字符 p[j+1] 之前不存在长度为 k+1 的前缀"p0 p1, …, pk-1 pk"跟后缀“pj-k pj-k+1, …, pj-1 pj"相等，那么是否可能存在另一个值 t+1 < k+1，使得长度更小的前缀 “p0 p1, …, pt-1 pt” 等于长度更小的后缀 “pj-t pj-t+1, …, pj-1 pj” 呢？如果存在，那么这个 t+1 便是 next[ j+1] 的值，此相当于利用已经求得的 next 数组（next [0, ..., k, ..., j]）进行 P 串前缀跟 P 串后缀的匹配。
func genNext(_ p: String) -> [Int] {
    var p = Array(p.characters)
    var next = Array<Int>(repeating: -1, count: p.count)
    var k = -1
    var j = 0
    while j < p.count - 1 {
        //p[k]表示前缀，p[j]表示后缀
        if k == -1 || p[j] == p[k] {
            j += 1
            next[j] = k + 1
            k = next[j]
        } else {
            k = next[k]
        }
    }
    return next
}

// 不该出现 p[j] = p[ next[j] ]。为什么呢？理由是：当 p[j] != s[i] 时，下次匹配必然是 p[ next [j]] 跟 s[i] 匹配，如果 p[j] = p[ next[j] ]，必然导致后一步匹配失败（因为 p[j] 已经跟 s[i] 失配，然后你还用跟 p[j] 等同的值 p[next[j]] 去跟 s[i] 匹配，很显然，必然失配），所以不能允许 p[j] = p[ next[j ]]。如果出现了 p[j] = p[ next[j] ] 咋办呢？如果出现了，则需要再次递归，即令 next[j] = next[ next[j] ]。
func genNextOptimize(_ p: String) -> [Int] {
    var p = Array(p.characters)
    var next = Array<Int>(repeating: -1, count: p.count)
    var k = -1
    var j = 0
    while j < p.count - 1 {
        if k == -1 || p[j] == p[k] {
            j += 1
//            next[j] = k + 1
            if p[j] == p[k + 1] {
                next[j] = next[k + 1]
            } else {
                next[j] = k + 1
            }
            k = k + 1
        } else {
            k = next[k]
        }
    }
    return next
}


// 假设现在文本串 S 匹配到 i 位置，模式串 P 匹配到 j 位置
//如果 j = -1，或者当前字符匹配成功（即 S[i] == P[j]），都令 i++，j++，继续匹配下一个字符；
//如果 j != -1，且当前字符匹配失败（即 S[i] != P[j]），则令 i 不变，j = next[j]。此举意味着失配时，模式串 P 相对于文本串 S 向右移动了 j - next [j] 位。
//换言之，当匹配失败时，模式串向右移动的位数为：失配字符所在位置 - 失配字符对应的 next 值（next 数组的求解会在下文的 3.3.3 节中详细阐述），即移动的实际位数为：j - next[j]，且此值大于等于1。

// O(m+n)
func kmpSearch(_ s: String, _ p: String) -> Int {
    var next = genNextOptimize(p)
    print(next)
    var s = Array(s.characters)
    var p = Array(p.characters)
    var i = 0, j = 0
    while i < s.count, j < p.count {
        if j == -1 || s[i] == p[j] {
            i += 1
            j += 1
        } else {
            j = next[j]
        }
    }
    if j == p.count {
        return i - j
    } else {
        return -1
    }
}

kmpSearch("baadaaafd", "aaa")

// 体会一下next计算优化后的强大
let next = genNext("aaaaa")
let next1 = genNextOptimize("aaaaa")


func findIndex(_ p: String, _ c: Character) -> Int {
    var p = Array(p.characters)
    for i in (0..<p.count).reversed() {
        if p[i] == c {
            return i
        }
    }
    return -1
}

// findIndex优化
// 因为i位置处的字符可能在pattern中多处出现，而我们需要的是最右边的位置，这样就需要每次循环判断了，非常麻烦，性能差。这里有个小技巧，就是使用字符作为下标而不是位置数字作为下标。这样只需要遍历一遍即可，这是空间换时间的做法，如果是纯8位字符只需要256个空间大小，而且对于大模式，可能本身长度就超过了256，所以这样做是值得的（这也是为什么数据越大，BM/Sunday算法越高效的原因之一）。
func findIndexOptimize(_ p: String) -> [Int] {
    var map = Array<Int>(repeating: -1, count: 256)
    var p = Array(p.characters)
    for i in 0..<p.count {
        map[Int(String(p[i]).unicodeScalars.first!.value)] = i
    }
    return map
}

// Sunday算法
func sundaySearch(_ s: String, _ p: String) -> Int {
    var s = Array(s.characters)
    var p = Array(p.characters)
    var i = 0, j = 0
    let map = findIndexOptimize(String(p))
    while i < s.count, j < p.count {
        if j == -1 || s[i] == p[j] {
            i += 1
            j += 1
        } else {
            let end = i + p.count - j
//            let index = findIndex(String(p), s[end])
            let index = map[Int(String(s[end]).unicodeScalars.first!.value)]
            if index == -1 {
                i = end + 1
            } else {
                i = end-index
            }
            j = 0
        }
    }
    if j == p.count {
        return i - j
    } else {
        return -1
    }
}

sundaySearch("baadaaafd", "aaa")

