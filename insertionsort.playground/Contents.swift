import Foundation

//正常写法
func insertionsort<T: Comparable>(_ array: [T]) -> [T] {
    var a = array
    for x in 1..<a.count {
        var y = x
        while y > 0 && a[y] < a[y - 1] {
            swap(&a[y - 1], &a[y])
            y -= 1
        }
    }
    return a
}

//优化：只让右面赋值成左边，最后再把最左边换成最小值
func insertionsort_shift<T: Comparable>(_ array: [T]) -> [T] {
    var a = array
    for x in 1..<a.count {
        var y = x
        let temp = a[y]
        while y > 0 && temp < a[y - 1] {
            a[y] = a[y-1]
            y -= 1
        }
        a[y] = temp
    }
    return a
}

//比较函数
func insertionSort_generic<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    var a = array
    for x in 1..<a.count {
        var y = x
        let temp = a[y]
        while y > 0 && isOrderedBefore(temp, a[y - 1]) {
            a[y] = a[y-1]
            y -= 1
        }
        a[y] = temp
    }
    return a
}

// 插入排序包括直接插入排序，二分插入排序（折半插入排序），希尔排序 http://blog.chinaunix.net/uid-28894229-id-4625483.html
// http://wiki.jikexueyuan.com/project/data-structure-sorting/ 这个网站总结了所有的排序


let list = [ 10, 0, 3, 9, 2, 14, 8 ]
insertionsort(list)
insertionsort_shift(list)
insertionSort_generic(list, <)

