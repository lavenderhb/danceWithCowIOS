

import UIKit

class tu: UIViewController {
    
    var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor() 
        
        
        //self.createData()
        // Do any additional setup after loading the view, typically from a nib.
    }
//    var arr:NSArray!
    
    //    func createData(){
    //
    //        let dataArrPath = NSBundle.mainBundle().pathForResource("StockTimeLine_sz002316", ofType: "plist") //调用数据
    //        arr = NSArray(contentsOfFile: dataArrPath!)! as NSArray //定义数据定量 arr
    //        let timeView = TimeLine()
    //        timeView.timeLineArray = arr
    //        timeView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: self.view.frame.size.height * 0.63) // 分时整图的图像位置 x，y 宽高
    //        self.view.addSubview(timeView)
    //
    ////        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)) {
    ////            sleep(3)
    ////
    ////            dispatch_async(dispatch_get_main_queue(),{
    ////                timeView.timeLineArray = self.arr
    ////
    ////                self.view.addSubview(timeView)
    ////
    ////            })
    ////        }
    //
    //
    //
    //    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}