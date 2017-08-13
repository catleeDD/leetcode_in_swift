/*
 56. Merge Intervals
 
 https://leetcode.com/problems/merge-intervals/description/
 
 Given a collection of intervals, merge all overlapping intervals.
 
 For example,
 Given [1,3],[2,6],[8,10],[15,18],
 return [1,6],[8,10],[15,18].
 */


public class Interval {
    public var start: Int
    public var end: Int
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

// 错误方法，分治法并不能做这道题
class Solution {
    func merge(_ intervals: [Interval]) -> [Interval] {
        if intervals.count <= 1 {
            return intervals
        }
        if intervals.count == 2 {
            let minIndex = intervals[0].start <= intervals[1].start ? 0 : 1
            let maxIndex = minIndex == 0 ? 1 : 0
            let s1 = intervals[minIndex].start
            let e1 = intervals[minIndex].end
            let s2 = intervals[maxIndex].start
            let e2 = intervals[maxIndex].end
            if e1 < s2 {
                return intervals
            }
            if s1 <= s2, e2 <= e1 {
                return [Interval(s1,e1)]
            }
            return [Interval(s1,e2)]
        }
        let mid = intervals.count / 2
        let left = merge(Array(intervals[0..<mid]))
        let right = merge(Array(intervals[mid..<intervals.count]))
        return left + right
    }
}

// 正确方法
class Solution1 {
    func merge(_ intervals: [Interval]) -> [Interval] {
        if intervals.count <= 1 {
            return intervals
        }
        let intervals = intervals.sorted { $0.start < $1.start }
        var result = [intervals[0]]
        for i in 1..<intervals.count {
            let last = result.removeLast()
            result.append(contentsOf: mergeTwo(last, intervals[i]))
        }
        return result
    }
    
    private func mergeTwo(_ left: Interval, _ right: Interval) -> [Interval] {
        let s1 = left.start
        let e1 = left.end
        let s2 = right.start
        let e2 = right.end
        if e1 < s2 {
            return [left, right]
        }
        if s1 <= s2, e2 <= e1 {
            return [Interval(s1,e1)]
        }
        return [Interval(s1,e2)]
    }
}

class Solution2 {
    func merge(_ intervals: [Interval]) -> [Interval] {
        if intervals.count <= 1 {
            return intervals
        }
        let intervals = intervals.sorted { $0.start < $1.start }
        
        var start = intervals[0].start
        var end = intervals[0].end;
        var result = [Interval]()
        
        for interval in intervals {
            if interval.start <= end {
                end = max(end, interval.end)
            } else {
                result.append(Interval(start, end))
                start = interval.start
                end = interval.end
            }
        }
        result.append(Interval(start, end))
        return result
    }
}

Solution1().merge([Interval(1,3),Interval(2,6),Interval(8,10),Interval(15,18)])



