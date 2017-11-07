//
//  KefuListViewController.swift
//  与牛共舞
//
//  Created by yansy on 2017/10/10.
//  Copyright © 2017年 Mac. All rights reserved.
//

import Foundation



class KefuListViewController:UIViewController
    {
    
    //客服推荐
    var KFTJCollectionView : UICollectionView!
    
    var TitleView : UIView!
    
    
    
//    override func viewDidLoad() {
//        
//        self.view.backgroundColor = UIColor.whiteColor()
//        
//        TitleView = UIView(frame: CGRectMake(0,0,240,25))
//        TitleView.layer.cornerRadius = 6
//        TitleView.backgroundColor = UIColor.whiteColor()
//        // 创建segmentcontrller背景视图
//        self.navigationItem.titleView = TitleView
//        
//        
//        //
//        let leftButton = UIButton(frame: CGRectMake(0, 0, 120, 25))
//        leftButton.backgroundColor = UIColor.whiteColor()
//        leftButton.layer.cornerRadius = 5
//        leftButton.setTitle("客服团队", forState: UIControlState.Normal)
//        leftButton.titleLabel?.font = UIFont.systemFontOfSize(13)
//        leftButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
//        
//        let CenterButton = UIButton(frame: CGRectMake(120, 0, 5, 25))
//        CenterButton.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
//        TitleView.addSubview(CenterButton)
//        
//        let RightButton = UIButton(frame: CGRectMake(120, 0, 120, 25))
//        RightButton.backgroundColor = UIColor(red: 55/255, green: 55/255, blue: 55/255, alpha: 1.0)
//        RightButton.titleLabel?.font = UIFont.systemFontOfSize(13)
//        RightButton.setTitle("互动大厅", forState: UIControlState.Normal)
//        RightButton.addTarget(self, action: #selector(ServiceViewController.CanTalkWithService), forControlEvents: UIControlEvents.TouchUpInside)
//        RightButton.layer.cornerRadius = 5
//        
//        TitleView.addSubview(RightButton)
//        TitleView.addSubview(leftButton)
//        
//        //searchBtn
//        let searchBtn = UIButton(frame: CGRectMake(0, 0, 30, 30))
//        searchBtn.setImage(UIImage(named: "968"), forState: UIControlState.Normal)
//        searchBtn.backgroundColor = UIColor.clearColor()
//        searchBtn.addTarget(self, action: #selector(searchBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
//        searchBtn.adjustsImageWhenHighlighted=false //使触摸模式下按钮也不会变暗
//        let rightBtn = UIBarButtonItem(customView: searchBtn)
//        self.navigationItem.rightBarButtonItem = rightBtn
//        
//        //backBtn
//        let backBtn  = UIButton(frame: CGRectMake(0, 0, 30, 30))
//        backBtn.setImage(UIImage(named: "back4"), forState: UIControlState.Normal)
//        backBtn.backgroundColor = UIColor.clearColor()
//        backBtn.adjustsImageWhenHighlighted = false
//        backBtn.addTarget(self, action: #selector(backBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
//        let leftBtn = UIBarButtonItem(customView: backBtn)
//        //用于消除左边空隙，要不然按钮顶不到最前面
//        let spacer = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil,action: nil)
//        spacer.width = -20;
//        self.navigationItem.leftBarButtonItems = [spacer, leftBtn]
//        
//        //客服推荐
//        let KFTJlayout = UICollectionViewFlowLayout()
//        KFTJCollectionView = UICollectionView(frame: CGRectMake(0, 25, UIScreen.mainScreen().bounds.width, 125), collectionViewLayout: KFTJlayout)
//        
//        // 注册cell
//        KFTJCollectionView!.registerClass(TestCollectionViewCell.self, forCellWithReuseIdentifier: "TestCEll")
//        KFTJCollectionView?.delegate = self
//        KFTJCollectionView?.dataSource = self
//        KFTJlayout.scrollDirection = .Horizontal
//        
//        let TestLabel : UILabel = UILabel(frame: CGRectMake(5,0, 70, 30))
//        TestLabel.backgroundColor = UIColor.whiteColor()
//        TestLabel.textColor = UIColor.redColor()
//        TestLabel.text = "客服推荐"
//        
//        backTableView.addSubview(TestLabel)
//        KFTJCollectionView?.backgroundColor = UIColor.whiteColor()
//        KFTJlayout.itemSize = CGSizeMake(85, 95)
//
//        
//        
//        
//    }
    
    func backBtnClick(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func searchBtnClick(){
        self.hidesBottomBarWhenPushed = true
        let serac = SearchViewController()
        self.navigationController?.pushViewController(serac, animated: true)
    }
    
    
    
}
