import UIKit
import AVKit

extension UIView {
    static let UIViewVideoPlayerTag = -12345678903
    static var UIViewVideoPlayerProp = "UIViewVideoPlayerProp"
    static var UIViewVideoPlayerLooperProp = "UIViewVideoPlayerLooperProp"

    func loadVideo(url: String, gravity: AVLayerVideoGravity = .resizeAspectFill, muted: Bool = true) {
        unloadVideo()
        var videoURL = URL(string: url)
        if url.range(of: "http://") == nil && url.range(of: "https://") == nil {
            if let filepath = Bundle.main.path(forResource: url.fileName(), ofType: url.fileExtension()) {
                videoURL = URL(fileURLWithPath: filepath)
            }
        }
            
        let container = UIView()
        container.tag = UIView.UIViewVideoPlayerTag
        container.frame = self.bounds
        container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(container)

        let playerItem = AVPlayerItem(url: videoURL!)
        let player = AVQueuePlayer(items: [playerItem])
        objc_setAssociatedObject(self, &UIView.UIViewVideoPlayerProp, player, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = gravity
        playerLayer.frame = self.bounds
        container.layer.addSublayer(playerLayer)
        let looper = AVPlayerLooper(player: player, templateItem: playerItem)
        objc_setAssociatedObject(self, &UIView.UIViewVideoPlayerLooperProp, looper, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        player.isMuted = muted
        player.play()
        
    }
    
    func unloadVideo() {
        for subview in self.subviews {
            if subview.tag == UIView.UIViewVideoPlayerTag {
                
                for sublayer in subview.layer.sublayers! {
                    if sublayer is AVPlayerLayer {
                        sublayer.removeFromSuperlayer()
                    }
                }
                subview.removeFromSuperview()

                objc_setAssociatedObject(self, &UIView.UIViewVideoPlayerLooperProp, nil, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

                let player = objc_getAssociatedObject(self, &UIView.UIViewVideoPlayerProp) as! AVPlayer
                player.removeObserver(self, forKeyPath: "timeControlStatus")
                player.pause()
            }
        }
    }
    
    func layoutVideo() {
        for subview in self.subviews {
            if subview.tag == UIView.UIViewVideoPlayerTag {
                for sublayer in subview.layer.sublayers! {
                    if sublayer is AVPlayerLayer {
                        sublayer.frame = subview.bounds
                    }
                }
            }
        }
    }

    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let player = objc_getAssociatedObject(self, &UIView.UIViewVideoPlayerProp) as? AVPlayer {
            if object as AnyObject? === player {
                if keyPath == "timeControlStatus" {
                    if player.timeControlStatus == .paused {
                        player.play()
                    }
                }
            }
        }
    }
    
}
