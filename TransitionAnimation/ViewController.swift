//
//  ViewController.swift
//  TransitionAnimation
//
//  Created by zj on 2017/8/28.
//  Copyright © 2017年 zj. All rights reserved.
//

import UIKit

let kWidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController,UIViewControllerTransitioningDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {

    let modalAnimator = ModalAnimation()
    let pics = ["pic1","pic2","pic3","pic4","pic5","pic6","pic1","pic2","pic3","pic4","pic5","pic6","pic1","pic2","pic3","pic4","pic5","pic6"]
    var mainCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        title = "List"
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: kWidth / 2.0 - 7.5, height: kWidth / 2.0 - 7.5)
        layout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        mainCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.backgroundColor = UIColor.white
        mainCollectionView.register(PicCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellId")
        view.addSubview(mainCollectionView)
    }
    
    //MARK:UICollectionViewDelegateFlowLayout,UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellId", for: indexPath) as! PicCollectionViewCell
        cell.imageView.image = UIImage(named: pics[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.imageName = pics[indexPath.item]
        let cell = collectionView.cellForItem(at: indexPath) as! PicCollectionViewCell
        let animator = Animator.shareAnimator
        animator.originalView = cell
        animator.originalFrame = cell.imageView.convert(cell.imageView.frame, to: view)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    
    //MARK:UIViewControllerTransitioningDelegate
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        modalAnimator.modalPresentingType = ModalPresentingType.present
        return modalAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        modalAnimator.modalPresentingType = ModalPresentingType.dismiss
        return modalAnimator
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


