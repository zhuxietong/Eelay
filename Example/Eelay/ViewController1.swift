//
//  ViewController1.swift
//  EeLay
//
//  Created by zhuxietong on 2017/2/20.
//  Copyright © 2017年 zhuxietong. All rights reserved.
//

import UIKit
import Eelay

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let head = UILabel()
        let name = UILabel()
        let age = UILabel()
        let content = UILabel()
        
        let back = UIView()
        back.backgroundColor = UIColor(white: 0.7, alpha: 0.9)
        
        
        
        
        view.eelay = [
            [back,[ee.T.L.B.R.safe]],
            [head,100,"100",[ee.T.X,[80,0]]],
            [name,.<200,"30",[ee.X,-20],[head,ee.B,ee.T,30]],
            [age,[name,ee.R,ee.L,10],[name,ee.Y]],
            [content,.>"200".+1000,[ee.L.B.R,[30,-30.+500,-30]],[name,ee.B,ee.T,40]]
        ]
       
        
        head.backgroundColor = UIColor(shex:"#ff0000")
        head.text = "head"
        head.textAlignment = .center
        
        name.backgroundColor = .red
        name.text = "name"
        name.textAlignment = .center
        
        age.backgroundColor = .brown
        age.text = "12岁"
        age.textAlignment = .center
        
        content.backgroundColor = .brown
        content.text = "content"
        content.textAlignment = .center
        

        view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
