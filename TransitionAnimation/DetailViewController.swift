//
//  DetailViewController.swift
//  TransitionAnimation
//
//  Created by zj on 2017/8/28.
//  Copyright © 2017年 zj. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var imageName : String!
    var imageView : UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: kWidth / 2.0 - 7.5, height: kWidth / 2.0 - 7.5))
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.center = view.center
        view.addSubview(imageView)
        
        let label = UILabel(frame: CGRect(x: 0, y: imageView.frame.maxY + 10, width: UIScreen.main.bounds.size.width, height: 50))
        label.text = "Transition Animation"
        label.textColor = UIColor.black
        label.textAlignment = NSTextAlignment.center
        label.center = CGPoint(x: view.center.x, y: label.center.y)
        view.addSubview(label)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
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
