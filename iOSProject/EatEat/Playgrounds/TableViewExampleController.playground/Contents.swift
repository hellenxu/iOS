import UIKit
import PlaygroundSupport

class TableViewExampleController: UIViewController, UITableViewDataSource {
    
    var tableView: UITableView?
    var names:[String] = ["Deanna", "Corliss", "Deyvn"]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = names[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = name
        return cell
    }
    
    func initTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView?.dataSource = self
        tableView?.backgroundColor = .white
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
}

PlaygroundPage.current.liveView = TableViewExampleController()
