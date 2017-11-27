//
//  XHDAVplayerView.swift
//  AVPlayer
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit
import AVKit
import SnapKit

@objc public protocol XHDAVplayerViewDelegate: NSObjectProtocol {
    func xhdPlayer(playerView: XHDAVplayerView, sliderTouchUpOut slider: UISlider)
    func xhdPlayer(playerView: XHDAVplayerView, playOrPause playBtn: UIButton)
}





public class XHDAVplayerView: UIView {
    
    var playerLayer: AVPlayerLayer?
    //时间
    var timeLabel: UILabel!
    //进度条
    var slider: UISlider!
    //是否正在滑动
    var sliding = false
    @IBOutlet weak var delegate: XHDAVplayerViewDelegate?
    
    //缓存进度
    var progressView: UIProgressView!

    //是否正在播放
    var playing = false
    var playBtn: UIButton!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        timeLabel = UILabel()
        timeLabel?.textColor = UIColor.white
        timeLabel?.font = UIFont.systemFont(ofSize: 12)
        addSubview(timeLabel)
        timeLabel?.snp.makeConstraints({ (make) in
            make.right.equalTo(self)
            make.bottom.equalTo(self).inset(5)
        })
        
        
        slider = UISlider()
        addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).inset(5)
            make.left.equalTo(self).offset(50)
            make.right.equalTo(self).inset(100)
            make.height.equalTo(15)
        }
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        
        slider.maximumTrackTintColor = UIColor.clear
        slider.minimumTrackTintColor = UIColor.white
        slider.setThumbImage(UIImage.init(named: "icon_video_vertical_position"), for: .normal)
        slider.addTarget(self, action: #selector(sliderTouchDown(slider:)), for: .touchDown)
        slider.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: .touchUpOutside)
        slider.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: .touchUpInside)
        slider.addTarget(self, action: #selector(sliderTouchUpOut(slider:)), for: .touchCancel)
        
        
        progressView = UIProgressView()
        progressView.trackTintColor = UIColor.clear
        progressView.progressTintColor = UIColor.white.withAlphaComponent(0.6)
        progressView.progress = 0
        self.insertSubview(progressView, belowSubview: slider)
        progressView.snp.makeConstraints { (make) in
            make.left.right.equalTo(slider)
            make.centerY.equalTo(slider)
            make.height.equalTo(2)
        }
        
        playBtn = UIButton()
        playBtn.setImage(UIImage.init(named: "icon_video_vertical_play"), for: .normal)
        playBtn.addTarget(self, action: #selector(self.playOrPause(button:)), for: .touchUpInside)
        addSubview(playBtn)
        
        playBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(slider)
            make.left.equalTo(self).offset(10)
            make.width.height.equalTo(30)
        }
        
    }
    
    @objc  func playOrPause(button: UIButton) {
        playing = !playing
        
        if playing {
            playBtn.setImage(UIImage.init(named: "icon_video_vertical_pause"), for: .normal)
        }else {
            playBtn.setImage(UIImage.init(named: "icon_video_vertical_play"), for: .normal)
        }
        delegate?.xhdPlayer(playerView: self, playOrPause: button)
    }
    
    @objc func sliderTouchDown(slider: UISlider) {
        sliding = true
    }
    
    @objc func sliderTouchUpOut(slider: UISlider) {
        //TODO: 代理处理
        delegate?.xhdPlayer(playerView: self, sliderTouchUpOut: slider)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer?.frame = self.bounds
    }
}
