/*
 447. Number of Boomerangs
 https://leetcode.com/problems/number-of-boomerangs/#/description
 
 Given n points in the plane that are all pairwise distinct, a "boomerang" is a tuple of points (i, j, k) such that the distance between i and j equals the distance between i and k (the order of the tuple matters).
 
 Find the number of boomerangs. You may assume that n will be at most 500 and coordinates of points are all in the range [-10000, 10000] (inclusive).
 
 Example:
 Input:
 [[0,0],[1,0],[2,0]]
 
 Output:
 2
 
 Explanation:
 The two boomerangs are [[1,0],[0,0],[2,0]] and [[1,0],[2,0],[0,0]]
 */

// Time limit


func abs(_ value: Int) -> Int {
    return value > 0 ? value : -value
}

struct Distance: Hashable {
    let x: Int
    let y: Int
    init(l: [Int], r: [Int]) {
        let tx = abs(l[0] - r[0])
        let ty = abs(l[1] - r[1])
        x = tx > ty ? ty : tx
        y = tx > ty ? tx : ty
    }
    
    var hashValue: Int {
        return x * 10000 + y
    }
}

func == (l: Distance, r: Distance) -> Bool {
    return l.x == r.x && l.y == r.y
}

class Solution {
    func numberOfBoomerangs(_ points: [[Int]]) -> Int {
        var set = Set<Distance>()
        for x in 0..<points.count {
            for y in x..<points.count {
                set.insert(Distance(l: points[x], r: points[y]))
            }
        }
        return set.count
    }
}

class Solution3 {
    func numberOfBoomerangs(_ points: [[Int]]) -> Int {
        var count = 0
        for a in points {
            var distances: [Int: Int] = [:]
            for b in points {
                let new = _distance(a, b)
                if let value = distances[new] {
                    distances[new] = value + 1
                } else {
                    distances[new] = 1
                }
            }
            for (_, value) in distances {
                if value > 1 {
                    count += value * (value - 1)
                }
            }
        }
        return count
    }
    
    private func _distance(_ a: [Int], _ b: [Int]) -> Int {
        let dx = a[0] - b[0]
        let dy = a[1] - b[1]
        return dx * dx + dy * dy
    }
}

// 稍微优化下
// 复杂度不变，还是O(n^2)时间 O(n)空间
class Solution1 {
    func numberOfBoomerangs(_ points: [[Int]]) -> Int {
        var count = 0
        for a in points {
            var distances: [Int: Int] = [:]
            for b in points {
                let new = _distance(a, b)
                distances[new] = (distances[new] ?? 0) + 1
            }
            for (_, value) in distances {
                count += value * (value - 1)
            }
        }
        return count
    }
    
    private func _distance(_ a: [Int], _ b: [Int]) -> Int {
        let dx = a[0] - b[0]
        let dy = a[1] - b[1]
        return dx * dx + dy * dy
    }
}

