//
//  ViewController.swift
//  WuKong
//
//  Created by ZhouXiang on 2017/4/14.
//  Copyright © 2017年 geekzxiang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var address: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestButton.addTarget(self, action:#selector(httpGet), for:.touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func httpGet() {
        let scriptUrl = address.text
        let myUrl = NSURL(string: scriptUrl!)
        let request = NSMutableURLRequest(url:myUrl! as URL)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(String(describing: error))")
                return
            }
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(String(describing: responseString))")
            
            //主线程刷新UI
            DispatchQueue.main.async(execute: {
                //多行显示
                self.content.lineBreakMode = NSLineBreakMode.byWordWrapping
                self.content.numberOfLines = 0
                
                self.content.text = responseString as String?
            })
        }
        task.resume()
    }

}

