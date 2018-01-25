
//Author :- Govind Lokhande
//ViewController class used to get the free apps avialble on appstore and show it on list.

import UIKit

class ViewController: UIViewController ,WebServiceDelegate,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var lblTextData: UILabel!
    var web = WebServiceInterface.sharedInstance
    var arrMutable: NSMutableArray = []
    var imagesArray : NSMutableArray = []
    var mutableDictionary = [String: AnyObject?]()
    var ResponseData = [NSDictionary]()
    
    @IBOutlet weak var tablData: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
        web.delegate = self
        self.callWebservice()
        tablData.separatorStyle = .none

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Calling the webservice .......
    func callWebservice(){
        let urlService =  Constant.GlobalConstants.kBaseURL + Constant.GlobalConstants.GETDATA_URL
        web.webServiceWithParameters( Url:  urlService)
    }
    
    // ======== Webservice interface delegate ======== //
    func requestFinish(response: Any) {
        DispatchQueue.main.async {
            var labelName = String()

            let  feed = (response as AnyObject) .value(forKey: "feed") as! NSDictionary
           let entry = feed.value(forKey: "entry") as! NSArray
            for obj in entry
            {
                let title = (obj as AnyObject).value(forKey: "title") as! NSDictionary
                labelName = title.value(forKey: "label") as! String
                self.arrMutable.add(labelName)
            }
            self.tablData.reloadData()
        }
    }
    func requestFailed(response : Any, errorMessage: String) {
        DispatchQueue.main.async {
            print("Error",errorMessage,response)
        }
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource Functions
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrMutable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "customcell"
        var cell: customcell! = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? customcell
        if cell == nil {
            tableView.register(UINib(nibName: "customcell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? customcell
        }

        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.lableOfFreeAppName.text = self.arrMutable [indexPath.row] as? String;
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row % 2 == 0)
        {
            cell.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.1)
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
  
    // this function calls when the user clicks on the cell...
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appName = self.arrMutable [indexPath.row] as? String;
        selectedApp(name: appName!)
    }
    
    // Navigation from one view to another....
    func selectedApp(name : String)
    {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "appName")
        DispatchQueue.main.async {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "AppInfo") as! AppInfoController
        self.present(next, animated: true, completion: nil)
        }
    }

}

