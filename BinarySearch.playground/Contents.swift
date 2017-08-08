//: Playground - noun: a place where people can play

import UIKit

func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound { //注意这里不能用<
        return nil
    }
//    let midIndex = (range.lowerBound + range.upperBound) / 2
    let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2 //防止溢出
    if a[midIndex] == key {
        return midIndex
    } else if a[midIndex] > key {
        return binarySearch(a, key: key, range: range.lowerBound..<midIndex)
    } else {
        return binarySearch(a, key: key, range: midIndex + 1..<a.count)
    }
}

let list = [ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67 ]
binarySearch(list, key: 19, range: 0..<list.count)


//non-recursive
func binarySearch_Nonrecursive<T: Comparable>(_ a: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        if a[midIndex] == key {
            return midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}

binarySearch_Nonrecursive(list, key: 19)
