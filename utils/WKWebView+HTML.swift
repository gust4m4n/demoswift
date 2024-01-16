import UIKit
import WebKit

extension WKWebView {
    func loadUrl(_ url: String) {
        let requestObj = NSURLRequest(url: URL(string: url)!)
        self.load(requestObj as URLRequest)        
    }
    
    func loadHtmlBody(_ html: String, marginLeft: CGFloat = 0.0, marginTop: CGFloat = 0.0, marginRight: CGFloat = 0.0, marginBottom: CGFloat = 0.0) {
        let template = """
            <header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>
            <style>
            @font-face
            {
                font-family: 'Roboto';
                font-weight: normal;
                src: url(Roboto-Regular.ttf);
            }
            @font-face
            {
                font-family: 'Roboto';
                font-weight: bold;
                src: url(Roboto-Bold.ttf);
            }
            @font-face
            {
                font-family: 'Roboto';
                font-weight: 900;
                src: url(Roboto-Black.ttf);
            }
            @font-face
            {
                font-family: 'Roboto';
                font-weight: 200;
                src: url(Roboto-Light.ttf);
            }
            @font-face
            {
                font-family: 'Roboto';
                font-weight: 500;
                src: url(Roboto-Medium.ttf);
            }
            body {
                font-family: 'Roboto';
                font-weight: normal;
                font-size: 14pt;
            }
            ol {
                list-style-type: none;
                counter-reset: item;
                margin: 0;
                padding: 0;
            }
            ol > li {
                display: table;
                counter-increment: item;
                margin-bottom: 0.6em;
            }
            ol > li:before {
                content: counters(item, '.') '. ';
                display: table-cell;
                padding-right: 0.6em;
            }
            li ol > li {
                margin: 0;
            }
            li ol > li:before {
                content: counters(item, '.') ' ';
            }
            table, th, td {
                border: 1px solid black;
                border-collapse: collapse;
                padding: 0.5rem;
            }
            
            </style>
            <body style='margin-left:\(marginLeft)pt;margin-right:\(marginRight)pt;margin-top:\(marginTop)pt;margin-bottom:\(marginBottom)pt;padding:0pt;'>
                \(html)
            </body>
            """
        self.loadHTMLString(template, baseURL: Bundle.main.bundleURL)
    }
    
    func loadHtmlText(_ html: String, margin: CGFloat = 0.0) {
        let template = """
            <span style="font-family: 'Roboto'; font-weight: regular; font-size: 14pt; color: #4A4949">\(html)</span>
            """
        self.loadHtmlBody(template, marginLeft: margin, marginTop: margin, marginRight: margin, marginBottom: margin)
    }
}
