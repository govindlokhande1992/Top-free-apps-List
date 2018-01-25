//Author: Govind Lokhande
//Constant class used to declaire the common contant varialble which can acess through out the app 
import UIKit
class Constant: NSObject {
    struct GlobalConstants {
        static let kBaseURL = "http://ax.itunes.apple.com/"
        static let GETDATA_URL = "WebObjects/MZStoreServices.woa/ws/RSS/topfreeapplications/limit=25/json"
    }
}
