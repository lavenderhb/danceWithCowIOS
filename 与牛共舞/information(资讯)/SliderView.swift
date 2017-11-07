//
//  SliderView.swift
//  SliderTitle
//

//


import UIKit

let ItemWidth = 95;
let itemHeight = 40;

let HeaderBgColor = UIColor.orangeColor();//顶部视图颜色
let normalColor = UIColor.whiteColor(); //未选中字体颜色
let selectColor = UIColor.blackColor(); //选中字体颜色
let Screen = UIScreen.mainScreen().bounds;

class SliderView:UIView, UIScrollViewDelegate{
    
    var sliderScrollView : UIScrollView;
    var showView : UIView;
    var headerView : UIView;
    var showScrollView : UIScrollView;
    var controllerScrollView : UIScrollView;
    var controllerArr :NSMutableArray{
        
        willSet (controllerArr){
            
            self.addController(controllerArr);
            controllerScrollView.contentSize = CGSizeMake(CGFloat(controllerArr.count) * Screen.size.width, CGRectGetHeight(controllerScrollView.frame));
        }
        didSet{
            
            
        }
    }
    
    var titleArray:NSMutableArray{
        
        willSet (titleArray){
            
            self.creatButton(titleArray,color: normalColor,scrollView: sliderScrollView);
            sliderScrollView.contentSize = CGSizeMake(CGFloat(titleArray.count) * CGFloat(ItemWidth), CGRectGetHeight(sliderScrollView.frame));
            self.creatButton(titleArray, color: selectColor, scrollView: showScrollView);
            showScrollView.contentSize = CGSizeMake(CGFloat(titleArray.count) * CGFloat(ItemWidth), CGRectGetHeight(showScrollView.frame));
            sliderScrollView.addSubview(showView);
            
            showView.addSubview(showScrollView);
        }
        didSet{
            
            
        }
    }
    
    override init(frame: CGRect) {
        sliderScrollView = UIScrollView.init();
        showScrollView = UIScrollView.init();
        showView = UIView();
        headerView = UIView();
        titleArray = NSMutableArray();
        controllerArr = NSMutableArray();
        controllerScrollView = UIScrollView.init();
        super.init(frame: frame);
        self.setUI();
    }
    
    func setUI(){
        // tiao
        headerView.frame = CGRect(x: 0, y: 0, width: Screen.size.width, height: 40);
        headerView.backgroundColor = UIColor.clearColor();
        self.addSubview(headerView);
        sliderScrollView.frame = CGRect(x: 0, y: 0, width: Screen.size.width, height: 40);
        sliderScrollView.delegate = self;
        sliderScrollView.backgroundColor = HeaderBgColor;
        sliderScrollView.showsHorizontalScrollIndicator = false;
        sliderScrollView.showsVerticalScrollIndicator = false;
        headerView.addSubview(sliderScrollView);
        showScrollView.frame = CGRect(x: 0, y: 0, width: Screen.size.width, height: 40);
        showScrollView.backgroundColor = HeaderBgColor;
        showScrollView.showsHorizontalScrollIndicator = false;
        showScrollView.showsVerticalScrollIndicator = false;
        showScrollView.bounces = false;
        showView.frame = CGRect(x: 0, y: 0, width: ItemWidth, height: itemHeight);
        showView.clipsToBounds = true;
        //        showView.userInteractionEnabled = false;
        
        controllerScrollView.frame = CGRect(x: 0, y: CGRectGetMaxY(sliderScrollView.frame), width: Screen.size.width, height: Screen.size.height - CGRectGetMaxY(sliderScrollView.frame));
        controllerScrollView.pagingEnabled = true;
        controllerScrollView.delegate = self;
        controllerScrollView.bounces = false;
        self.addSubview(controllerScrollView);
    }
    
    func addController(arr : NSMutableArray) {
        for i in 0 ..< arr.count {
            /*
            let someClass : AnyClass = NSClassFromString(arr[i] as! String)!
            let vc : UIViewController = someClass.alloc() as! UIViewController;
            */
            //             let someClass : AnyClass = NSClassFromString(arr[i] as! String)!
           
            // 注意强制解包的问题 ********************
            let someClass : AnyClass = NSClassFromString(arr[i] as! String)!
           let vc = (someClass as! UIViewController.Type).init()
           
            vc.view.frame = CGRect(x: CGFloat(i) * CGFloat(Screen.size.width), y: 0, width: Screen.size.width, height: CGRectGetHeight(controllerScrollView.frame));
            controllerScrollView.addSubview(vc.view);

        }
        
    }
    
    func creatButton(titleArr : NSMutableArray,color : UIColor,scrollView : UIScrollView){
        
        for index in 0 ..< titleArr.count{
            
            let button = UIButton(type: UIButtonType.Custom);
            button.frame = CGRect(x: index * ItemWidth, y: 0, width: ItemWidth, height: itemHeight);
            button.setTitle(titleArr[index] as? String, forState: UIControlState.Normal);
            button.titleLabel?.font = UIFont.systemFontOfSize(15)
            button.setTitleColor(color, forState: UIControlState.Normal);
            if scrollView.isEqual(sliderScrollView) {
                
                button.tag = index;
                //                button .addTarget(self, action:Selector("btnClick(button:UIButton)"), forControlEvents: UIControlEvents.TouchUpInside)
                //                button .addTarget(self, action:Selector(SliderView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                
                button.addTarget(self, action: #selector(SliderView.btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                
                
            }
            scrollView.addSubview(button);
        }
    }
    
    
    func btnClick(button:UIButton){
        
        controllerScrollView.setContentOffset(CGPointMake(Screen.size.width * CGFloat(button.tag), 0), animated: true);
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        if scrollView .isEqual(controllerScrollView) {
            showView.frame = CGRect(x: scrollView.contentOffset.x * (CGFloat(ItemWidth) / Screen.size.width), y: showView.frame.origin.y, width: showView.frame.size.width, height: showView.frame.size.height);
            showScrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x * (CGFloat(ItemWidth) / Screen.size.width), y: 0);
        }
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView .isEqual(controllerScrollView) {
            
            //            print(CGRectGetMaxX(showView.frame) - sliderScrollView.contentOffset.x,Screen.size.width);
            if CGRectGetMaxX(showView.frame) - sliderScrollView.contentOffset.x > Screen.size.width {
                sliderScrollView.setContentOffset(CGPoint(x:sliderScrollView.contentOffset.x + CGRectGetMaxX(showView.frame) - sliderScrollView.contentOffset.x - Screen.size.width , y: 0), animated: true);
            }else if sliderScrollView.contentOffset.x - CGRectGetMinX(showView.frame) >= 0{
                
                sliderScrollView.setContentOffset(CGPoint(x:sliderScrollView.contentOffset.x  - sliderScrollView.contentOffset.x + CGRectGetMinX(showView.frame), y: 0), animated: true);
            }
        }
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
