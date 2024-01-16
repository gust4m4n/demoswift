import UIKit
import IHKeyboardAvoiding

enum SheetDirection {
    case up
    case down
    case right
}

extension UIViewController {
    static var sheetControllerProp = "sheetControllerProp"
    static var sheetDidAutoCloseProp = "sheetDidAutoCloseProp"
    static var sheetAnimatedProp = "sheetAnimatedProp"
    static var sheetDirectionProp = "sheetDirectionProp"
    static var sheetDidAutoCloseFuncProp = "sheetDidAutoCloseFuncProp"
    static var sheetHeightProp = "sheetHeightProp"

    func sheetShow(width: CGFloat = 0.0, height: CGFloat = 0.0, keyboardAvoiding: Bool = false, direction: SheetDirection = .up, autoClose: Bool = true, animated: Bool = true, didPushed: (() -> Void)? = nil, didAutoClose: (() -> Void)? = nil) {
        if let window = UIApplication.shared.keyWindow {
            self.view.endEditing(true)
                    
            if let controller = objc_getAssociatedObject(window, &UIViewController.sheetControllerProp) as? UIViewController {
                controller.sheetClose { [self] in
                    self.sheetShowInternal(width: width, height: height, keyboardAvoiding: keyboardAvoiding, direction: direction, autoClose: autoClose, animated: animated, didPushed: didPushed, didAutoClose: didAutoClose)
                }
            } else {
                self.sheetShowInternal(width: width, height: height, keyboardAvoiding: keyboardAvoiding, direction: direction, autoClose: autoClose, animated: animated, didPushed: didPushed, didAutoClose: didAutoClose)
            }
        }
    }
    
    func sheetShowInternal(width: CGFloat = 0.0, height: CGFloat = 0.0, keyboardAvoiding: Bool = false, direction: SheetDirection = .up, autoClose: Bool = true, animated: Bool = true, didPushed: (() -> Void)? = nil, didAutoClose: (() -> Void)? = nil) {
        
        if let window = UIApplication.shared.keyWindow {
            objc_setAssociatedObject(window, &UIViewController.sheetControllerProp, self, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &UIViewController.sheetDidAutoCloseProp, didAutoClose, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &UIViewController.sheetDirectionProp, direction, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            objc_setAssociatedObject(self, &UIViewController.sheetAnimatedProp, animated, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            if keyboardAvoiding == true {
                KeyboardAvoiding.avoidingView = self.view
            }

            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(sheetRespondToPanGesture))
            self.view.addGestureRecognizer(panGesture)

            let r = UIScreen.main.bounds
            let overlay = UIView()
            window.addSubview(overlay)
            
            overlay.translatesAutoresizingMaskIntoConstraints = true
            overlay.frame = CGRect(x: 0.0, y: 0.0, width: r.size.width, height: r.size.height)
            
            if autoClose == true {
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sheetRespondToTapGesture))
                tapGesture.cancelsTouchesInView = false
                overlay.addGestureRecognizer(tapGesture)
            }

            overlay.addSubview(self.view)
            self.view.translatesAutoresizingMaskIntoConstraints = true
            var cx: CGFloat = width
            if cx == 0.0 {
                cx = r.size.width
            }
            var cy: CGFloat = height
            if cy == 0.0 {
                let cxmax = UIScreen.main.bounds.width
                var cymax = UIScreen.main.bounds.height
                if #available(iOS 11.0, *) {
                    if let window = UIApplication.shared.keyWindow {
                        let topPadding = window.safeAreaInsets.top
                        cymax = cymax - topPadding
                    }
                }

                let size = self.view.systemLayoutSizeFitting(CGSize(width: cxmax, height: 0.0), withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
                cy = size.height
                if (cy > cymax) {
                    cy = cymax
                }
            }
            else {
                cy = height
            }

            self.viewWillAppear(animated)
            overlay.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            var x: CGFloat = (r.size.width / 2.0) - (cx / 2.0)
            var y: CGFloat = 0.0
            if direction == .up {
                y = r.size.height
            } else
            if direction == .down {
                y = -cy
            } else
            if direction == .right {
                x = -cx
                cy = UIScreen.main.bounds.size.height
            }
            
            objc_setAssociatedObject(self, &UIViewController.sheetHeightProp, cy, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            self.view.frame = CGRect(x: x, y: y, width: cx, height: cy)
            
            UIView.animate(withDuration: animated == true ? 0.2 : 0.0, delay: 0.0, options: .curveEaseIn, animations: {
                overlay.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
                if direction == .up {
                    self.view.frame = CGRect(x: x, y: (r.size.height-cy), width: cx, height: cy)
                } else
                if direction == .down {
                    self.view.frame = CGRect(x: x, y: 0.0, width: cx, height: cy)
                } else
                if direction == .right {
                    self.view.frame = CGRect(x: 0.0, y: 0.0, width: cx, height: cy)
                }
            }, completion: { finished in
                self.viewDidAppear(animated)
                didPushed?()
            })
        }
    }
    
    func sheetUpdateSize() {
        let cxmax = UIScreen.main.bounds.width
        let size = self.view.systemLayoutSizeFitting(CGSize(width: cxmax, height: 0.0), withHorizontalFittingPriority: UILayoutPriority.required, verticalFittingPriority: UILayoutPriority.defaultLow)
        self.view.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - size.height, width: size.width, height: size.height)
        objc_setAssociatedObject(self, &UIViewController.sheetHeightProp, size.height, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func sheetClose(didPop: (() -> Void)? = nil) {
        
        if let window = UIApplication.shared.keyWindow {
            if let animated = objc_getAssociatedObject(self, &UIViewController.sheetAnimatedProp) as? Bool {
                if let direction = objc_getAssociatedObject(self, &UIViewController.sheetDirectionProp) as? SheetDirection {
                    self.view.endEditing(true)
                    let r = UIScreen.main.bounds
                    let overlay = self.view.superview
                    self.viewWillDisappear(animated)
                    
                    UIView.animate(withDuration: animated == true ? 0.2 : 0.0, delay: 0.0, options: .curveEaseIn, animations: {
                        overlay?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
                        if direction == .up {
                            self.view.frame = CGRect(x: self.view.frame.origin.x, y: r.size.height,
                                                     width: self.view.frame.width, height: self.view.frame.size.height)
                        } else
                        if direction == .down {
                            self.view.frame = CGRect(x: self.view.frame.origin.x, y: -self.view.frame.size.height,
                                                     width: self.view.frame.width, height: self.view.frame.size.height)
                        } else
                        if direction == .right {
                            self.view.frame = CGRect(x: -self.view.frame.width, y: 0.0,
                                                     width: self.view.frame.width, height: self.view.frame.size.height)
                        }
                    }, completion: { finished in
                        self.view.superview?.removeFromSuperview()
                        self.viewDidDisappear(animated)
                        objc_setAssociatedObject(window, &UIViewController.sheetControllerProp, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                        didPop?()
                    })
                        
                } // if let direction
            } // if let animated
        } // if let window
    }
    
    static func sheetShowing() -> UIViewController? {
        if let window = UIApplication.shared.keyWindow {
            return objc_getAssociatedObject(window, &UIViewController.sheetControllerProp) as? UIViewController
        } else {
            return nil
        }
    }
    
    @objc func sheetRespondToTapGesture(sender: UITapGestureRecognizer) {
        let loc = sender.location(in: sender.view)
        let subview = sender.view?.hitTest(loc, with: nil)
        if subview == self.view.superview {
            sheetClose {
                if let didAutoClose = objc_getAssociatedObject(self, &UIViewController.sheetDidAutoCloseProp) as! (() -> Void)? {
                    didAutoClose()
                }
            }
        }
    }

    @objc func sheetRespondToPanGesture(recognizer: UIPanGestureRecognizer) {
        self.view.endEditing(true)
        let direction = objc_getAssociatedObject(self, &UIViewController.sheetDirectionProp) as! SheetDirection
        if recognizer.state == .began || recognizer.state == .changed {
            let translation = recognizer.translation(in: self.view)
            if direction == .up {
                let r = UIScreen.main.bounds
                if (self.view.frame.origin.y + self.view.frame.size.height + translation.y) >= r.size.height {
                    recognizer.view!.center = CGPoint(x: recognizer.view!.center.x, y: recognizer.view!.center.y + translation.y)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                }
            } else
            if direction == .down {
                if (self.view.frame.origin.y + self.view.frame.size.height + translation.y) <= self.view.frame.size.height {
                    recognizer.view!.center = CGPoint(x: recognizer.view!.center.x, y: recognizer.view!.center.y + translation.y)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                }
            } else
            if direction == .right {
                if (self.view.frame.origin.x + self.view.frame.size.width + translation.x) <= self.view.frame.size.width {
                    recognizer.view!.center = CGPoint(x: recognizer.view!.center.x + translation.x, y: recognizer.view!.center.y)
                    recognizer.setTranslation(CGPoint.zero, in: self.view)
                }
            }

        } else
        if recognizer.state == .ended || recognizer.state == .failed || recognizer.state == .cancelled {
            let r = UIScreen.main.bounds
            let snap: CGFloat = 32.0
            
            if direction == .up {
                var cy = 0.0
                if let cyValue = objc_getAssociatedObject(self, &UIViewController.sheetHeightProp) as? Double {
                    cy = cyValue;
                }
                if (r.size.height - self.view.frame.origin.y) < (cy / 2.0) {
                    sheetClose {
                        if let didAutoClose = objc_getAssociatedObject(self, &UIViewController.sheetDidAutoCloseProp) as! (() -> Void)? {
                            didAutoClose()
                        }
                    }
                } else {
                    let animated = objc_getAssociatedObject(self, &UIViewController.sheetAnimatedProp) as? Bool
                    UIView.animate(withDuration: animated == true ? 0.2 : 0.0, delay: 0.0, options: .curveEaseIn, animations: {
                        let r = self.view.frame
                        self.view.frame = CGRect(x: r.origin.x, y: UIScreen.main.bounds.size.height-r.size.height,
                            width: r.size.width, height: r.size.height)
                    });
                }
            } else
            if direction == .down {
                if (self.view.frame.origin.y + self.view.frame.size.height) < (self.view.frame.size.height-snap) {
                    sheetClose {
                        if let didAutoClose = objc_getAssociatedObject(self, &UIViewController.sheetDidAutoCloseProp) as! (() -> Void)? {
                            didAutoClose()
                        }
                    }
                } else {
                    let r = self.view.frame
                    self.view.frame = CGRect(x: r.origin.x, y: 0.0,
                        width: r.size.width, height: self.view.frame.size.height)
                }
            } else
            if direction == .right {
                if (self.view.frame.origin.x + self.view.frame.size.width) < (self.view.frame.size.width/2.0) {
                    sheetClose {
                        if let didAutoClose = objc_getAssociatedObject(self, &UIViewController.sheetDidAutoCloseProp) as! (() -> Void)? {
                            didAutoClose()
                        }
                    }
                } else {
                    let animated = objc_getAssociatedObject(self, &UIViewController.sheetAnimatedProp) as? Bool
                    UIView.animate(withDuration: animated == true ? 0.2 : 0.0, delay: 0.0, options: .curveEaseIn, animations: {
                        let r = self.view.frame
                        self.view.frame = CGRect(x: 0.0, y: r.origin.y,
                            width: r.size.width, height: self.view.frame.size.height)
                    });
                }
            }
        }
    }
    
}

