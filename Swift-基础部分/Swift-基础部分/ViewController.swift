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
        shopingList.append("Ha");
//        testArray("name", shopingList, <#appendElements: String#>...)
        testArray(listName: "name", shopingList, "ele1","ele2")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }

}


//============================= 集合类型 Collection types
//--数组

var shopingList: [String] = ["Eggs","Milk"];

//简写外部参数名（Shorthand External Parameter Names）
func testArray( #listName: String, var list: [String], appendElements: String ...) -> (){
    for element in appendElements {
        list.append(element)
    }
    println("finaly, the list is\(list)")

}



//============================= 元组 tuples

let tuples1 = ("discription", 100, 10)
let tuplesHasArray = ([1,2], 100, 10)
//let tuplesHasDictionary = ("key":1,100,10);

//func testTuples() ->(String, Int)
//{
//    return ("hello", 10)
//}