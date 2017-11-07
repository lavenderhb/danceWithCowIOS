import UIKit

enum ChatBubbleTypingType
{
    case nobody
    case me
    case somebody
}

class ChatTableView:UITableView,UITableViewDelegate,UITableViewDataSource
{
    //用于保存所有消息
    var bubbleSection:NSMutableArray!
    //数据源，用于与 ViewController 交换数据
    var chatDataSource:ChatDataSource!
    
    var snapInterval:NSTimeInterval!
    var typingBubble:ChatBubbleTypingType!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        //the snap interval in seconds implements a headerview to seperate chats
        self.snapInterval = NSTimeInterval(60 * 60 * 24) //one day
        self.typingBubble = ChatBubbleTypingType.nobody
        self.bubbleSection = NSMutableArray()
        
        super.init(frame:frame,  style:style)
        
        self.backgroundColor = UIColor.clearColor()
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        self.delegate = self
        self.dataSource = self
    }
    
    override func reloadData()
    {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bubbleSection = NSMutableArray()
        var count =  0
        if ((self.chatDataSource != nil))
        {
            count = self.chatDataSource.rowsForChatTable(self)
            
            if(count > 0)
            {
                let bubbleData =  NSMutableArray(capacity:count)
                
                for i in 0 ..< count
                {
                    let object =  self.chatDataSource.chatTableView(self, dataForRow:i)
                    bubbleData.addObject(object)
                }
                bubbleData.sortUsingComparator(sortDate)
                
                var last =  ""
                
                var currentSection = NSMutableArray()
                // 创建一个日期格式器
                let dformatter = NSDateFormatter()
                // 为日期格式器设置格式字符串
                dformatter.dateFormat = "dd"
                
                for i in 0 ..< count
                {
                    let data =  bubbleData[i] as! MessageItem
                    // 使用日期格式器格式化日期，日期不同，就新分组
                    let datestr = dformatter.stringFromDate(data.date as NSDate)
                    if (datestr != last)
                    {
                        currentSection = NSMutableArray()
                        self.bubbleSection.addObject(currentSection)
                    }
                    (self.bubbleSection[self.bubbleSection.count-1] as AnyObject).addObject(data)
                    
                    last = datestr
                }
            }
        }
        super.reloadData()
        
        //滑向最后一部分
//        let secno = self.bubbleSection.count - 1
//        let indexPath =  NSIndexPath.init(index: secno)
        
//        self.scrollToRowAtIndexPath(indexPath,atScrollPosition:UITableViewScrollPosition.Bottom,animated:true)
    }
    
    //按日期排序方法
    func sortDate( m1: Any, m2: Any) -> NSComparisonResult {
        if((m1 as! MessageItem).date.timeIntervalSince1970 < (m2 as! MessageItem).date.timeIntervalSince1970)
        {
            return NSComparisonResult.OrderedAscending
        }
        else
        {
            return NSComparisonResult.OrderedDescending
        }
    }
    
    
    
    
    
    //第一个方法返回分区数
    override func numberOfRowsInSection(section: Int) -> Int {
        var result = self.bubbleSection.count
        if (self.typingBubble != ChatBubbleTypingType.nobody)
        {
            result += 1;
        }
        return result;
    }
    
    
    

    //返回指定分区的行数
    func tableView(_tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section >= self.bubbleSection.count)
        {
            return 1
        }
        
        print((self.bubbleSection[section] as AnyObject).count+1)
        return (self.bubbleSection[section] as AnyObject).count+1
    }
    
    
    
    //用于确定单元格的高度，如果此方法实现得不对，单元格与单元格之间会错位
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0)
        {
            return TableHeaderViewCell.getHeight()
        }
        let section  =  self.bubbleSection[indexPath.section] as! NSMutableArray
        let data = section[indexPath.row - 1]
        
        let item =  data as! MessageItem
        let height  =  max(item.insets.top + item.view.frame.size.height  + item.insets.bottom, 52) + 17
        return height
    }
    
    
    //返回自定义的 TableViewCell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0)
        {
            let cellId = "HeaderCell"
            
            let hcell =  TableHeaderViewCell(reuseIdentifier:cellId)
            let section =  self.bubbleSection[indexPath.section] as! NSMutableArray
            let data = section[indexPath.row] as! MessageItem
            
            hcell.setDate(data.date)
            return hcell
        }
        // Standard
        let cellId = "ChatCell"
        
        let section =  self.bubbleSection[indexPath.section] as! NSMutableArray
        let data = section[indexPath.row - 1]
        
        let cell =  ChatTableViewCell(data:data as! MessageItem, reuseIdentifier:cellId)
        
        return cell

    }
    
    
    
}
