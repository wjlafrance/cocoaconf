import UIKit

class ViewController: UIViewController {

    @IBAction func showSunspiderInMobileSafari(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.webkit.org/perf/sunspider-1.0.2/sunspider-1.0.2/driver.html"))
    }

}
