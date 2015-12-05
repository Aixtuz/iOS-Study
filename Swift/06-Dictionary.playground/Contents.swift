//: Playground - noun: a place where people can play

import UIKit

//: let: 定义不可变字典, var: 定义可变字典
//: 常用字典类型: [String NSObject]
let dict = ["name": "zhangsan", "title": "boss", "age": 18]

// 遍历字典
for (key, value) in dict {
    print("\(key) -- \(value)")
}

//: 定义并实例化字典
var dict1 = [String: NSObject]()

//: 设置字典内容
dict1["name"] = "laowang"
dict1["age"] = "30"
dict1

//: key已存在, 会覆盖赋值
dict1["name"] = "abc"
dict1

//: 删除内容
dict1.removeValueForKey("age")
dict1

//: 合并字典
var dict2 = ["title": "boss"]
dict2["name"] = "wangxiaoer"

//: 利用循环遍历合并
for (key, value) in dict2 {
    // updateValue, 更新指定key的value
    // 存在则覆盖, 不存在则新建
    dict1.updateValue(value, forKey: key)
}
dict1
dict2


