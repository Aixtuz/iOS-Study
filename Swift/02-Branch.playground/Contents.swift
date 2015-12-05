//: Playground - noun: a place where people can play

import UIKit

//: 必须条件判断, 不可非零即真
let i = 10
if i > 0 {
    print("hello")
}
/*:
?: 可选项 && !: 强制解包
 - Method? : 未必成功实例化, 故先判断不为空
 - 确定不为空, 则 Method! 强制解包
*/
let url = NSURL(string: "http://www.baidu.com")
if url != nil {
    let request = NSURLRequest(URL: url!)
}

//: Swift 简约写法: if let 后url一定有值, 无需强制解包
if let url = NSURL(string: "http://www.baidu.com") {
    let request = NSURLRequest(URL: url)
}

//: 指定变量类型, 可选项
var str: NSString?
str = "hello"

//: 打印可见: Optional 可选提示
print(str?.length)

//: ?? 快速判空, 多用于tableView数据源方法
let len1 = 10
let len2 = len1 + (str?.length ?? 0)

var array: [String]?
array = ["hello", "world"]
print(array?.count ?? 0)

/*:
tips:
 - 懒加载: if (!_XXX) -> if (_XXX != nil)
 - 使用? : 为空则停止
 - 使用! : 为空则报错
*/
