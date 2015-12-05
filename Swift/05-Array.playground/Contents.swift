//: Playground - noun: a place where people can play

import UIKit

//: let: 定义不可变数组, var: 定义可变数组
let array1 = ["zhangsan", "lisi"]

//: 遍历数组
for a in array1 {
    let str = "hello" + "-" + a
    print(str)
}

//: 不可变数组, 不可追加元素
// array1.append("abc")

var array2 = ["aaa", "bbb"]
//: 可变数组追加元素
array2.append("ccc")

//: 数组元素类型不一致, 则数组类型是[NSObject]
var array3 = ["zzz", 11, "123"]
for a in array3 {
    let str = "hi \(a)"
    print(str)
}

//: 数组定义, 但未初始化
var array4: [String]

//: 初始化字符串可变数组
array4 = [String]()

array4.append("hello")
array4.append("world")

//: 数组容量
print(array4.capacity)

// 删除数组元素, 是否保持容量
array4.removeAll(keepCapacity: false)

//: tips: 无论是否保持容量, 不足均在当前基础上翻倍
for i in 0...10 {
    array4.append("hello \(i)")
    print("\(array4) : \(array4.capacity)")
}





