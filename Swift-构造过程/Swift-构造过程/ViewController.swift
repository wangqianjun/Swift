//
//  ViewController.swift
//  Swift-构造过程
//
//  Created by 王钱钧 on 14/11/5.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

// 与OC中构造器不同，Swift的构造器无需返回值

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//================1 存储型属性的初始赋值
/*
类和结构体在实例创建时，必须为所有存储属性设置合适的初始值。存储属性的值不能处于一个未知的状态
*/
// 构造器




//================2 定制化构造过程
//================3 默认构造器
//================4 值类型的构造器代理
//================5 类的继承和构造过程
//================6 通过闭包和函数来设置属性的默认值