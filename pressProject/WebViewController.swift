//
//  WebViewController.swift
//  pressProject
//
//  Created by minsoo kim on 02/12/2018.
//  Copyright © 2018 minsoo kim. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{
    
    var urlString : String? 
    var webView:WKWebView?

    @IBOutlet weak var containerView: UIView!
    
    override func loadView() {
        super.loadView()
        //경고창 믿지마. 없으면 Webview가 안 뜸.
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.goBack))
        webView = WKWebView(frame: createWKWebViewFrame(size:view.frame.size))
        containerView!.addSubview(webView!)
        self.webView!.uiDelegate = self
        self.webView!.navigationDelegate = self
        
        webView!.allowsBackForwardNavigationGestures = true
        if let siteAddress = urlString{
        let url = URL(string: siteAddress)

            let request = URLRequest(url: url!)
            self.webView!.load(request)
            print("Request는 되었는디")
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        webView!.frame = createWKWebViewFrame(size:size)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
extension WebViewController{
    fileprivate func createWKWebViewFrame(size: CGSize) -> CGRect{
        let navigationHeight: CGFloat = 60
        let toolbarHeight : CGFloat  = 44
        let height = size.height - navigationHeight - toolbarHeight
        return CGRect(x:0, y:0, width:size.width, height: height)
    }
}


extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // show indicator
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // dismiss indicator
        
        // if url is not valid {
        //    decisionHandler(.cancel)
        // }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // dismiss indicator
        
//        goBackButton.isEnabled = webView.canGoBack
//        goForwardButton.isEnabled = webView.canGoForward
        navigationItem.title = webView.title
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // show error dialog
    }
}

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

