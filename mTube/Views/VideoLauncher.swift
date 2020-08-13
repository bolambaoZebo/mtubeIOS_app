//
//  VideoTableCell.swift
//  mTube
//
//  Created by DNA-Z on 7/1/20.
//  Copyright © 2020 DNA-Z. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    
    let activityIndicatiorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    lazy var pauseplayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        //action handler for the buttonclick
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        return button
    }()
    
    var isPlaying = true
    
    @objc func handlePause(){
        
        if isPlaying {
            player?.pause()
            pauseplayButton.setImage(UIImage(named: "play"), for: .normal)

        }else{
            player?.play()
            pauseplayButton.setImage(UIImage(named: "pause"), for: .normal)
            
        }
//        isPlaying ? player?.pause() : player?.play()
        isPlaying = !isPlaying
    }
    let videoLengthLabel: UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let videoCLengthLabel: UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let videoSlider: UISlider = {
       let slider = UISlider()
        let image = UIImage(named: "redot")
        slider.setThumbImage(UIImage(named: "redot"), for: .normal)
        slider.maximumTrackTintColor = .white
        slider.minimumTrackTintColor = .red
        slider.translatesAutoresizingMaskIntoConstraints = false
        //action function for slider change
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    @objc func handleSliderChange() {
        
        if let duration = player?.currentItem?.duration{
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            let secondsText = String(format: "%02d", Int64(value) % 60)
            let minutesText = String(format: "%02d", Int64(value) / 60)
            videoCLengthLabel.text = "\(minutesText):\(secondsText)"
                
            player?.seek(to: seekTime, completionHandler: { (completedSeek)
                in
            })
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupPlayerView()
        setupGradientLayer()
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatiorView)
        activityIndicatiorView.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        activityIndicatiorView.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pauseplayButton)
        pauseplayButton.centerXAnchor.constraint(equalTo: controlsContainerView.centerXAnchor).isActive = true
        pauseplayButton.centerYAnchor.constraint(equalTo: controlsContainerView.centerYAnchor).isActive = true
        pauseplayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pauseplayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -4).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoCLengthLabel)
        videoCLengthLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        videoCLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoCLengthLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        videoCLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: videoCLengthLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        
        
        backgroundColor = .black
        
    }
    
    private func setupPlayerView() {
        //getting url from github
        let urlString = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        
        if let url = NSURL(string: urlString){
            player = AVPlayer(url: url as URL)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
            let interval = CMTime(value: 1, timescale: 2)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in

                let seconds = CMTimeGetSeconds(progressTime)
                let secondsString = String(format: "%02d", Int(seconds) % 60)
                let minutesString = String(format: "%02d", Int(seconds) / 60)
                self.videoCLengthLabel.text = "\(minutesString):\(secondsString)"
                
                //moving the slider thumb
                if let duration = self.player?.currentItem?.duration {
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSeconds)
                }
            })
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // the video is ready activate play and pause button
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatiorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pauseplayButton.isHidden = false
            
        // setup the string duration of the right buttom side of the video frame
        if let duration = player?.currentItem?.duration {
            let seconds = CMTimeGetSeconds(duration)
//            let currentseconds = CMTimeGetSeconds()
            
            let secondsText = Int(seconds) % 60
            let minutesText = String(format: "%02d", Int(seconds) / 60)
            videoLengthLabel.text = "\(minutesText):\(secondsText)"
        
          }
        }
        
    }
    
    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.9, 1.1]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not been implemented")
    }
}
//class VideoTCell: UITableViewDataSource {
//    
//}
class VideoLauncher: NSObject{
    
    func showVideoPlayer(){
        print("Playing video animation")
        
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = UIColor.white
            
            view.frame = CGRect(x: keyWindow.frame.width - 30, y: keyWindow.frame.height - 30, width: 30, height: 30)
            
            // 16 X 9 is the aspect ratio of all hd videos
            let heightframe = keyWindow.frame.width * 9 / 16
            let videoPlayFrame =  CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: heightframe)
            
            //where i added the video frame
            let videoPlayView = VideoPlayerView(frame: videoPlayFrame)
            view.addSubview(videoPlayView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:{
                
                view.frame = keyWindow.frame
            }, completion: { (completedAnimation) in
                //do something here
                UIApplication.shared.setStatusBarHidden(false, with: .fade)
            })
        }
    }
}
