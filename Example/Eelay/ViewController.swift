//
//  ViewController.swift
//  EeLay
//
//  Created by zhuxietong on 2017/2/20.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//

import UIKit
import Eelay
class ViewController:UITableViewController {
    
    
    let list:[[String:String]] = [
        ["name":"iOS developer","img":"swift.png","info":"iOS是由苹果公司开发的移动操作系统[1] "],
        ["name":"java developer","img":"java.jpg","info":"Java是一门面向对象编程语言，不仅吸收了C++语言的各种优点，还摒弃了C++里难以理解的多继承、指针等概念，因此Java语言具有功能强大和简单易用两个特征。Java语言作为静态面向对象编程语言的代表，极好地实现了面向对象理论，允许程序员以优雅的思维方式进行复杂的编程[1]  。"],
        ["name":"python developer","img":"python.jpg","info":"Python具有丰富和强大的库。它常被昵称为胶水语言，能够把用其他语言制作的各种模块（尤其是C/C++）很轻松地联结在一起。"],
        ["name":"php developer","img":"php.jpg","info":"PHP（外文名:PHP: Hypertext Preprocessor，中文名：“超文本预处理器”）是一种通用开源脚本语言。语法吸收了C语言、Java和Perl的特点，利于学习，使用广泛，主要适用于Web开发领域。PHP 独特的语法混合了C、Java、Perl以及PHP自创的语法。它可以比CGI或者Perl更快速地执行动态网页。用PHP做出的动态页面与其他的编程语言相比，PHP是将程序嵌入到HTML（标准通用标记语言下的一个应用）文档中去执行，执行效率比完全生成HTML标记的CGI要高许多；PHP还可以执行编译后代码，编译可以达到加密和优化代码运行，使代码运行更快。"],
        ["name":"Go developer","img":"list","info":"Go是一种编译型语言，它结合了解释型语言的游刃有余，动态类型语言的开发效率，以及静态类型的安全性。它也打算成为现代的，支持网络与多核计算的语言。要满足这些目标，需要解决一些语言上的问题：一个富有表达能力但轻量级的类型系统，并发与垃圾回收机制，严格的依赖规范等等。这些无法通过库或工具解决好，因此Go也就应运而生了。"],
        ["name":"ruby developer","img":"list","info":"Ruby，一种简单快捷的面向对象（面向对象程序设计）脚本语言，在20世纪90年代由日本人松本行弘(Yukihiro Matsumoto)开发，遵守GPL协议和Ruby License。它的灵感与特性来自于 Perl、Smalltalk、Eiffel、Ada以及 Lisp 语言。由 Ruby 语言本身还发展出了JRuby（Java平台）、IronRuby（.NET平台）等其他平台的 Ruby 语言替代品。Ruby的作者于1993年2月24日开始编写Ruby，直至1995年12月才正式公开发布于fj（新闻组）。因为Perl发音与6月诞生石pearl（珍珠）相同，因此Ruby以7月诞生石ruby（红宝石）命名。"],
        ["name":"html developer","img":"list","info":"万维网上的一个超媒体文档称之为一个页面（外语：page）。作为一个组织或者个人在万维网上放置开始点的页面称为主页（外语：Homepage）或首页，主页中通常包括有指向其他相关页面或其他节点的指针（超级链接），所谓超级链接，就是一种统一资源定位器（Uniform Resource Locator，外语缩写：URL）指针，通过激活（点击）它，可使浏览器方便地获取新的网页。这也是HTML获得广泛应用的最重要的原因之一。在逻辑上将视为一个整体的一系列页面的有机集合称为网站（Website或Site）。超级文本标记语言（英文缩写：HTML）是为“网页创建和其它可在网页浏览器中看到的信息”设计的一种标记语言。"],
        ["name":"javascript developer","img":"list","info":"JavaScript一种直译式脚本语言，是一种动态类型、弱类型、基于原型的语言，内置支持类型。它的解释器被称为JavaScript引擎，为浏览器的一部分，广泛用于客户端的脚本语言，最早是在HTML（标准通用标记语言下的一个应用）网页上使用，用来给HTML网页增加动态功能。"],
        
        ]
    
    
    override func viewDidLoad() {
        
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.rowHeight = UITableViewAutomaticDimensionUITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ctr = ViewController1()
        self.navigationController?.pushViewController(ctr, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? Cell
        cell?.model = list[indexPath.row]
        return cell!
        
    }
    
    
    
    
}

class Cell:UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addLayRules()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var model:[String:String] = [String:String]()
    {
        didSet{
            let img = UIImage(named: model["img"] ?? "swift.png")
            headV.image = img
            nameL.text = model["name"]
            infoL.text = model["info"]
            
        }
    }
    
    let headV = UIImageView()
    let nameL = UILabel()
    let infoL = UILabel()
    func addLayRules() {
        contentView.eelay = [
            [headV,"50",50,[ee.T.L,[16,16]]],
            [nameL,[headV,ee.R.Y,ee.L.Y,[10,0]],[ee.R,-16]],
            [infoL,[headV,ee.B,ee.T,10],[ee.L.B.R,[16,-8,-16]],.<"90".&1000]
        ]
        infoL.numberOfLines = 0
    }
    
}

