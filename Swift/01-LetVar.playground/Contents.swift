//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: 常量: let 不可改, 变量: var 可修改
let x = 10
// x = 20

var y = 10
y = 20

let i = 10
let j = 10.5

//: 定义指定类型
let z: Double = 5

//: 必须同类运算
let k1 = Double(i) + j
let k2 = i + Int(j)
let k3 = j + z

//: tips:
//: - 必须同类运算，绝不存在隐式转换
//: - 优先使用常量: let, 需要变更时再修改为变量: var

//: [[class alloc] initWithXxx] -> class(Xxx: )
let view = UIView(frame: CGRectMake(0, 0, 100, 100))
view.backgroundColor = UIColor.cyanColor()

let btn = UIButton(frame: CGRectMake(20, 20, 50, 50))
btn.setTitle("hello", forState: UIControlState.Normal)

//: [obj add:Xxx] -> obj.add(Xxx)
view.addSubview(btn)
