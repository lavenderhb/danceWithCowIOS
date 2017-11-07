import Foundation

/*
  数据提供协议
*/
protocol ChatDataSource
{
    /*返回对话记录中的全部行数*/
    func rowsForChatTable( tableView:ChatTableView) -> Int
    /*返回某一行的内容*/
    func chatTableView(tableView:ChatTableView, dataForRow:Int)-> MessageItem
}
