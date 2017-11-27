//
//  ViewController.swift
//  AVPlayer
//
//  Created by 韩承海 on 2017/11/26.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var playerView: XHDAVplayerView!
    var playerItem: AVPlayerItem!
    var avplayer: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    var displayLink: CADisplayLink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let url = URL.init(string: "http://bos.nj.bpc.baidu.com/tieba-smallvideo/11772_3c435014fb2dd9a5fd56a57cc369f6a0.mp4") else {
            fatalError()
        }
        playerItem = AVPlayerItem.init(url: url)
        //缓存进度
        playerItem.addObserver(self, forKeyPath: "loadedTimeRanges", options: NSKeyValueObservingOptions.new, context: nil)
        //加载状态
        playerItem.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
        avplayer = AVPlayer.init(playerItem: playerItem)
        playerLayer = AVPlayerLayer.init(player: avplayer)
        playerLayer.videoGravity = .resizeAspect
        playerLayer.contentsScale = UIScreen.main.scale
        
        self.playerView.playerLayer = playerLayer
        self.playerView.layer.insertSublayer(playerLayer, at: 0)
        
        
        //定时器
        displayLink = CADisplayLink.init(target: self, selector: #selector(updateTime))
        displayLink.add(to: RunLoop.main, forMode: .commonModes)
    }

    
    // MARK: - 监听 加载状态 和 缓存进度
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loadedTimeRanges" {
        //TODO: 缓存进度
            let loadedTime = avalableDurationWithPlayerItem()
            let totalTime = CMTimeGetSeconds(playerItem.duration)
            let percent = loadedTime / totalTime
            self.playerView.progressView.progress = Float(percent)
        }else if keyPath == "status" {
            if playerItem.status == .readyToPlay {
                self.avplayer.play()
            }else {
                print("加载异常")
            }
        }
    }
    
    
    // MARK: - 更新时间
    @objc func updateTime() {
        //暂停的时候不处理时间
        if !self.playerView.playing {
            return
        }
        //当前播放到的时间
        let currentTime = CMTimeGetSeconds(self.avplayer.currentTime())
        //总时间  timescale压缩比例
        let totalTime = TimeInterval(self.playerItem.duration.value) / TimeInterval(playerItem.duration.timescale)
        let timeStr = "\(formatPlayTime(seconds: currentTime))/\(formatPlayTime(seconds: totalTime))"
        playerView.timeLabel?.text = timeStr
        //TODO: 播放进度
        if !self.playerView.sliding {//没有滑动的时候更新
            self.playerView.slider.value = Float(currentTime / totalTime)
        }
    }
    
    

    
    
    
    
    // MARK: - 格式化时间
    func formatPlayTime(seconds: TimeInterval) -> String {
        if seconds.isNaN {
            return "00:00"
        }
        //
        let min = Int(seconds / 60)
        //取余
        let sec = Int(seconds.truncatingRemainder(dividingBy: 60))
        let str = String.init(format: "%02d:%02d", min, sec)
        return str
    }
   
    
    func avalableDurationWithPlayerItem() -> TimeInterval {
        guard let loadedTimeRanges = avplayer.currentItem?.loadedTimeRanges, let first = loadedTimeRanges.first  else {
            fatalError()
        }
        let timeRange = first.timeRangeValue
        let startSeconds = CMTimeGetSeconds(timeRange.start)
        let durationSecond = CMTimeGetSeconds(timeRange.duration)
        let result = startSeconds + durationSecond
        return result
    }
    
    
    
    
    // MARK: - 销毁
    deinit {
        playerItem.removeObserver(self, forKeyPath: "status")
        playerItem.removeObserver(self, forKeyPath: "loadedTimeRanges")
    }


}


extension ViewController: XHDAVplayerViewDelegate {
    func xhdPlayer(playerView: XHDAVplayerView, sliderTouchUpOut slider: UISlider) {
        if self.avplayer.status == .readyToPlay {
            let duration = slider.value * Float(CMTimeGetSeconds((self.avplayer.currentItem?.duration)!))
            let seekTime = CMTimeMake(Int64(duration), 1)
            //跳转指定时间点
            self.avplayer.seek(to: seekTime, completionHandler: { (b) in
                //改变状态
                self.playerView.sliding = false
            })
            
        }
    }
    
    func xhdPlayer(playerView: XHDAVplayerView, playOrPause playBtn: UIButton) {
        if !playerView.playing {
            self.avplayer.pause()
        }else {
            if avplayer.status == .readyToPlay {
                self.avplayer.play()
            }
        }
    }
}
