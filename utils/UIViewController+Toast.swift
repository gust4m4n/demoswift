import UIKit
import IHKeyboardAvoiding

extension UIViewController {
    static let toastTag = -333333
    static var toastControllerProp = "toastControllerProp"
    static var toastDidAutoCloseProp = "toastDidAutoCloseProp"
    static var toastAnimatedProp = "toastAnimatedProp"
    static var toastDirectionProp = "toastDirectionProp"
    
    static public func toastShowing() -> UIViewController? {
        if let window = UIApplication.shared.keyWindow {
            if let controller = objc_getAssociatedObject(window, &UIViewController.toastControllerProp) as? UIViewController? {
                return controller
            }
        }
        return nil
    }

    public func toastShow(width: CGFloat = 0.0, height: CGFloat = 0.0, extraHeight: CGFloat = 0.0, autoClose: Bool = true, direction: Bool = true, keyboardAvoiding: Bool = true, animated: Bool = true, didShow: (() -> Void)? = nil, didAutoClose: (() -> Void)? = nil) {
        
        if let window = UIApplication.shared.keyWindow {
            
            if objc_getAssociatedObject(window, &UIViewController.toastControllerProp) != nil {
                return
            }
            
            self.view.endEditing(true)

            objc_setAssociatedObject(window, &UIViewController.toastControllerProp, self, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &UIViewController.toastDidAutoCloseProp, didAutoClose, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &UIViewController.toastAnimatedProp, animated, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &UIViewController.toastDirectionProp, direction, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            if keyboardAvoiding == true {
                KeyboardAvoiding.avoidingView = self.view
            }

            let r = UIScreen.main.bounds
            let overlay = UIView()
            overlay.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)

            var found = false
            for subview in window.subviews {
                if subview.tag == UIViewController.toastTag {
                    window.insertSubview(overlay, belowSubview: subview)
                    found = true
                }
            }
            if found == false {
                window.addSubview(overlay)
            }

            overlay.translatesAutoresizingMaskIntoConstraints = true
            overlay.frame = CGRect(x: 0.0, y: 0.0, width: r.size.width, height: r.size.height)

            if autoClose == true {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toastRespondToTapGesture))
                tapGesture.cancelsTouchesInView = false
                overlay.addGestureRecognizer(tapGesture)
            }

            overlay.addSubview(self.view)
            self.view.translatesAutoresizingMaskIntoConstraints = true
            var cx: CGFloat = width
            if cx == 0.0 {
                cx = r.size.width * 0.85
            }
            var cy: CGFloat = height
            if cy == 0.0 {
                let cxmax = cx //UIScreen.main.bounds.width * 0.85
                
                var cymax = UIScreen.main.bounds.height
                if #available(iOS 11.0, *) {
                    if let window = UIApplication.shared.keyWindow {
                        cymax = cymax - (window.safeAreaInsets.top + window.safeAreaInsets.bottom)
                    }
                }

                let size = self.view.systemLayoutSizeFitting(CGSize(width: cxmax, height: 0.0), withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
                cy = size.height + extraHeight
                if (cy > cymax) {
                    cy = cymax
                }
            }

            self.viewWillAppear(animated)
            
            var bottomPadding: CGFloat = 0.0
            if #available(iOS 11.0, *) {
                if let window = UIApplication.shared.keyWindow {
                    bottomPadding = window.safeAreaInsets.bottom
                }
            }
            
            let x: CGFloat = (r.size.width / 2.0) - (cx / 2.0)
            let y: CGFloat = r.size.height - (cy + bottomPadding)            

            if animated == false {
                self.view.frame = CGRect(x: x, y: y, width: cx, height: cy)
                self.viewDidAppear(animated)
                didShow?()
            }
            else {
                if direction == true {
                    self.view.frame = CGRect(x: x, y: r.size.height, width: cx, height: cy)
                } else {
                    self.view.frame = CGRect(x: x, y: -r.size.height, width: cx, height: cy)
                }
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                    self.view.frame = CGRect(x: x, y: y, width: cx, height: cy)
                }, completion: { finished in
                    self.viewDidAppear(animated)
                    didShow?()
                })
            }
            
        } // if let window
    }
    
    public func toastClose(didClose: (() -> Void)? = nil) {
        if let window = UIApplication.shared.keyWindow {
            if let animated = objc_getAssociatedObject(self, &UIViewController.toastAnimatedProp) as? Bool {
                if let direction = objc_getAssociatedObject(self, &UIViewController.toastDirectionProp) as? Bool {
                    self.view.endEditing(true)
                    let r = UIScreen.main.bounds
                    self.viewWillDisappear(animated)
                    
                    UIView.animate(withDuration: animated == true ? 0.2 : 0.0, delay: 0.0, options: .curveEaseIn, animations: {
                        if direction == true {
                            self.view.frame = CGRect(x: self.view.frame.origin.x, y: r.size.height,
                                                     width: self.view.frame.width, height: self.view.frame.size.height)
                        } else {
                            self.view.frame = CGRect(x: self.view.frame.origin.x, y: -self.view.frame.size.height,
                                                     width: self.view.frame.width, height: self.view.frame.size.height)
                        }
                    }, completion: { finished in
                        self.view.superview?.removeFromSuperview()
                        self.viewDidDisappear(animated)
                        objc_setAssociatedObject(window, &UIViewController.toastControllerProp, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                        didClose?()
                    })

                } // if let direction
            } // if let animated
        } // if let window

    }
    
    @objc func toastRespondToTapGesture(sender: UITapGestureRecognizer) {
        let loc = sender.location(in: sender.view)
        let subview = sender.view?.hitTest(loc, with: nil)
        if subview == self.view.superview {
            toastClose(didClose: {
                if let didAutoClose = objc_getAssociatedObject(self, &UIViewController.toastDidAutoCloseProp) as! (() -> Void)? {
                    didAutoClose()
                }
            })
        }
    }

}

