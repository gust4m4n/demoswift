import UIKit
import IHKeyboardAvoiding

extension UIViewController {
    static var popupControllerProp = "popupControllerProp"
    static var popupDidAutoCloseProp = "popupDidAutoCloseProp"
    static var popupAnimatedProp = "popupAnimatedProp"
    static var popupDirectionProp = "popupDirectionProp"
    
    static public func popupShowing() -> UIViewController? {
        if let window = UIApplication.shared.keyWindow {
            if let controller = objc_getAssociatedObject(window, &UIViewController.popupControllerProp) as? UIViewController? {
                return controller
            }
        }
        return nil
    }

    public func popupShow(width: CGFloat = 0.0, height: CGFloat = 0.0, extraHeight: CGFloat = 0.0, autoClose: Bool = true, direction: Bool = true, keyboardAvoiding: Bool = true, animated: Bool = true, didShow: (() -> Void)? = nil, didAutoClose: (() -> Void)? = nil) {
        
        if let window = UIApplication.shared.keyWindow {
            
            if objc_getAssociatedObject(window, &UIViewController.popupControllerProp) != nil {
                return
            }
            
            self.view.endEditing(true)

            objc_setAssociatedObject(window, &UIViewController.popupControllerProp, self, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &UIViewController.popupDidAutoCloseProp, didAutoClose, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &UIViewController.popupAnimatedProp, animated, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &UIViewController.popupDirectionProp, direction, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            if keyboardAvoiding == true {
                KeyboardAvoiding.avoidingView = self.view
            }

            let r = UIScreen.main.bounds
            let overlay = UIView()
            window.addSubview(overlay)

            overlay.translatesAutoresizingMaskIntoConstraints = true
            overlay.frame = CGRect(x: 0.0, y: 0.0, width: r.size.width, height: r.size.height)

            if autoClose == true {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(popupRespondToTapGesture))
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
            overlay.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            let x: CGFloat = (r.size.width / 2.0) - (cx / 2.0)
            let y: CGFloat = (r.size.height / 2.0) - (cy / 2.0)
            if animated == false {
                overlay.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
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
                    overlay.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
                    self.view.frame = CGRect(x: x, y: y, width: cx, height: cy)
                }, completion: { finished in
                    self.viewDidAppear(animated)
                    didShow?()
                })
            }
            
        } // if let window
    }
    
    public func popupClose(didClose: (() -> Void)? = nil) {
        if let window = UIApplication.shared.keyWindow {
            if let animated = objc_getAssociatedObject(self, &UIViewController.popupAnimatedProp) as? Bool {
                if let direction = objc_getAssociatedObject(self, &UIViewController.popupDirectionProp) as? Bool {
                    self.view.endEditing(true)
                    let r = UIScreen.main.bounds
                    let overlay = self.view.superview
                    self.viewWillDisappear(animated)
                    
                    UIView.animate(withDuration: animated == true ? 0.2 : 0.0, delay: 0.0, options: .curveEaseIn, animations: {
                        overlay?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
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
                        objc_setAssociatedObject(window, &UIViewController.popupControllerProp, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                        didClose?()
                    })

                } // if let direction
            } // if let animated
        } // if let window

    }
    
    @objc func popupRespondToTapGesture(sender: UITapGestureRecognizer) {
        let loc = sender.location(in: sender.view)
        let subview = sender.view?.hitTest(loc, with: nil)
        if subview == self.view.superview {
            popupClose(didClose: {
                if let didAutoClose = objc_getAssociatedObject(self, &UIViewController.popupDidAutoCloseProp) as! (() -> Void)? {
                    didAutoClose()
                }
            })
        }
    }

}

