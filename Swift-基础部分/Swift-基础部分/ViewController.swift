//
//  ViewController.swift
//  Swift-基础部分
//
//  Created by 王钱钧 on 14/10/30.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

let constant: String = "常量"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let (count, array) = testArray(listName: "name", shopingList, "ele1","ele2")
        println("count = \(count), array = \(array)")
        
        testOptionalBinding()
        testImplicitlyUnwrappedOptionals()
//        testAssertion()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }

}

//==============================可选绑定optional binding
//“使用可选绑定（optional binding）来判断可选类型是否包含值，如果包含就把值赋给一个临时常量或者变量”

func testOptionalBinding(){
    var fooString: String?
    if let str = fooString {
        println("str has value:\(str)")
    } else {
        println("str is nil")
    }
}

//=============================隐式可选类型 implicitly unwrapped optionals
func testImplicitlyUnwrappedOptionals() {
    let possibleString: String? = "An optional string"
    let assumedString: String! = "An implicitly unwrapped obtionals"
    println(possibleString)
    println(possibleString!)
    println(assumedString)
}

//===============================断言assertion
func testAssertion() {
    let age = -3
    assert(age >= 0, "a person's age can not be less than zero");
}

//============================= 集合类型 Collection types
//--数组

var shopingList: [String] = ["Eggs","Milk"];
var someInts = [Int]()
var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
var anotherThreeDoubles = [Double](count: 3, repeatedValue: 3.3)
var sixDoubles = threeDoubles + anotherThreeDoubles

//简写外部参数名（Shorthand External Parameter Names）
func testArray( #listName: String, var list: [String], appendElements: String ...) -> (Int, [AnyObject]){
    for element in appendElements {
        list.append(element)
        list += ["a"]
    }
    println("finaly, the list is\(list)")
    
    return (list.count, list)
}



//============================= 元组 tuples

let tuples1 = ("discription", 100, 10)
let tuplesHasArray = ([1,2], 100, 10)
//let tuplesHasDictionary = ("key":1,100,10);

//func testTuples() ->(String, Int)
//{
//    return ("hello", 10)
//}