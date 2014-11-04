//
//  ViewController.swift
//  Swift-类和结构体
//
//  Created by 王钱钧 on 14/10/31.
//  Copyright (c) 2014年 王钱钧. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


func initData() {
    // 构造器语法的最简单形式是在结构体或者类的类型名称后跟随一个空括弧，其属性均会初始化为默认值
    let someResolution = Resolution()
    let someVideoModel = VideoModel()
    
    
    //结构体类型的成员逐一构造器 Memberwise Initializers (类实例没有)
    let vga = Resolution(width: 640, height: 480)
    
    //所有的结构体和枚举类型都是值类型（值类型操作实际上是操作其拷贝）
    var hd = vga
    
    //
    someVideoModel.resolution = hd
    someVideoModel.interlaced = true
    someVideoModel.frameRate = 25.0
    
    let alsoVideoModel = someVideoModel
    
    // 恒等运算符（===），判断两个常量或者变量是否引用同一个类实例
    
    // 属性 Properties
    
    
}

