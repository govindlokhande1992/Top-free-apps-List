
import UIKit
//Author :- Govind Lokhande
//Protocol to Handle the webservices request response.
@objc protocol WebServiceDelegate: class
{
    func requestFinish(response:Any) // delegate method 1
    func requestFailed(response:Any,errorMessage:String) // delegate method 2
}

//Class to handle the webservice interfaces.
class WebServiceInterface: NSObject {
    
    var delegate:WebServiceDelegate?
    static let sharedInstance : WebServiceInterface = {
        let instance = WebServiceInterface()
        return instance
    }()
    // Function call to webservice.
    func webServiceWithParameters(Url:String) {
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: Url)!
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
                self.delegate?.requestFailed(response:"", errorMessage: (error?.localizedDescription)!)
            }
            else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        self.delegate?.requestFinish(response: json)
                    }
                }
                catch {
                    self.delegate?.requestFailed(response:"", errorMessage:"Server not responding, Please try again")
                }
            }
        })
        task.resume()
    }
}
