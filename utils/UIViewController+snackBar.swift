import UIKit

enum SnackBarPosition {
    case top
    case bottom
}

enum SnackBarAnimation {
    case slide
    case fade
}

let SnackBarTag = 5000000

extension UIViewController {
    
    func showSnackBar(position: SnackBarPosition = .top, duration: TimeInterval = 3.0, animation: SnackBarAnimation = .fade, didFinish: (() -> Void)? = nil) {
        if let window = UIApplication.shared.keyWindow {
            let r = UIScreen.main.bounds

            self.viewWillAppear(true)
            let size = self.view.systemLayoutSizeFitting(CGSize(width: r.size.width, height: 0.0), withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
            self.view.tag = SnackBarTag
            
            if animation == .fade {
                
                self.view.alpha = 0.0
                if position == .top {
                    var topPadding: CGFloat = 0.0
                    if #available(iOS 11.0, *) {
                        if let window = UIApplication.shared.keyWindow {
                            topPadding = window.safeAreaInsets.top
                        }
                    }
                    self.view.frame = CGRect(x: 0.0, y: topPadding, width: size.width, height: size.height)
                } else
                if position == .bottom {
                    var bottomPadding: CGFloat = 0.0
                    if #available(iOS 11.0, *) {
                        if let window = UIApplication.shared.keyWindow {
                            bottomPadding = window.safeAreaInsets.bottom
                        }
                    }
                    self.view.frame = CGRect(x: 0.0, y: r.size.height - (size.height + bottomPadding), width: size.width, height: size.height)
                }
                
                window.addSubview(self.view)
                UIView.animate(withDuration: 0.3, delay: 0.0, animations: {
                    self.view.alpha = 1.0
                }, completion: { finished in
                    self.viewDidAppear(true)
                    Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (timer) in
                        self.viewWillDisappear(true)
                        UIView.animate(withDuration: 0.3, delay: 0.0, animations: {
                            self.view.alpha = 0.0
                        }, completion: { finished in
                            self.viewDidDisappear(true)
                            self.view.removeFromSuperview()
                            didFinish?()
                        })
                    }
                })
            } else
            if animation == .slide {
                if position == .top {
                    self.view.frame = CGRect(x: 0.0, y: -size.height, width: size.width, height: size.height)
                } else
                if position == .bottom {
                    self.view.frame = CGRect(x: 0.0, y: r.size.height, width: size.width, height: size.height)
                }
            
                window.addSubview(self.view)
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                    if position == .top {
                        var topPadding: CGFloat = 0.0
                        if #available(iOS 11.0, *) {
                            if let window = UIApplication.shared.keyWindow {
                                topPadding = window.safeAreaInsets.top
                            }
                        }
                        self.view.frame = CGRect(x: 0.0, y: topPadding, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    } else
                    if position == .bottom {
                        var bottomPadding: CGFloat = 0.0
                        if #available(iOS 11.0, *) {
                            if let window = UIApplication.shared.keyWindow {
                                bottomPadding = window.safeAreaInsets.bottom
                            }
                        }
                        self.view.frame = CGRect(x: 0.0, y: r.size.height - self.view.frame.size.height - bottomPadding, width: self.view.frame.size.width, height: self.view.frame.size.height)
                    }
                }, completion: { finished in
                    self.viewDidAppear(true)
                    Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (timer) in
                        self.viewWillDisappear(true)
                        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                            if position == .top {
                                self.view.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: -self.view.frame.size.height)
                            } else
                            if position == .bottom {
                                self.view.frame = CGRect(x: 0.0, y: r.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
                            }
                        }, completion: { finished in
                            self.viewDidDisappear(true)
                            self.view.removeFromSuperview()
                            didFinish?()
                        })
                    }
                })
            }
                
        }
    }

}

