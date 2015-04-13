import Foundation
import XCPlayground

public class Networking {
    
    public static let sharedInstance = Networking()
    
    // MARK: - Initilization
    public init() {
        println("Singleton is being initialized");
    }
    
    // MARK: - Request
    /**
    Creates a request for the specified method, URL string, parameters, and parameter encoding.
    
    :param: method The HTTP method.
    :param: URLString The URL string.
    :param: parameters The parameters. `nil` by default.
    :param: encoding The parameter encoding. `.URL` by default.
    
    :returns: The created request.
    */
    func get(request: NSURLRequest!, callback: (String, String?) -> Void) {
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if error != nil {
                callback("", error.localizedDescription)
            } else {
                var result = NSString(data: data, encoding: NSASCIIStringEncoding)!
                callback(result as String, nil)
            }
        }
        task.resume()
    }
}

// Request Google
var request = NSMutableURLRequest(URL: NSURL(string: "http://www.google.com")!)
Networking.sharedInstance.get(request){
    (data, error) -> Void in
    if error != nil {
        println(error)
    } else {
        println(data)
    }
}

XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

