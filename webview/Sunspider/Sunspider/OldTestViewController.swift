import UIKit


class OldTestViewController: UIViewController {

    var webView: UIWebView?

    override func viewWillAppear(animated: Bool) {
        let request = NSURLRequest(URL: NSURL(string: "http://www.webkit.org/perf/sunspider-1.0.2/sunspider-1.0.2/driver.html"))

        webView = UIWebView(frame: view.bounds)

        view.addSubview(webView!)

        webView!.loadRequest(request)
    }
}
