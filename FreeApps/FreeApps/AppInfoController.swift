
//Author:- Govind Lokhande
//AppInfoController class used to diplay information of the selected app.

import UIKit

class AppInfoController: UIViewController {
    
    @IBOutlet var infoLable: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard 
        let appName : String =  defaults.value(forKey: "appName") as! String//code to get the current selected apps information.
        infoLable.text = appName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Click event of the dismiss button to dismiss the app info view.
    @IBAction func clickOnDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
