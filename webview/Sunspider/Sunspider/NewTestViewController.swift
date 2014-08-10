import UIKit
import WebKit

class NewTestViewController: UIViewController {

    var webView: WKWebView?

    override func viewWillAppear(animated: Bool) {
        let request = NSURLRequest(URL: NSURL(string: "http://www.webkit.org/perf/sunspider-1.0.2/sunspider-1.0.2/driver.html"))

        webView = WKWebView(frame: view.bounds)

        view.addSubview(webView!)

        webView!.loadRequest(request)
    }

}
