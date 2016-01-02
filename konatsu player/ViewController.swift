//
//  ViewController.swift
//  konatsu player
//
//  Created by 迫 佑樹 on 2016/01/02.
//  Copyright © 2016年 迫 佑樹. All rights reserved.
//

import UIKit
import AVFoundation

var player:AVAudioPlayer = AVAudioPlayer()

class ViewController: UIViewController {

    var pause = false

    var music = list[0]
    
    var playing = false
    
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var scrubSlider: UISlider!

    @IBOutlet var timeLabel: UILabel!
    @IBAction func scrub(sender: AnyObject) {
        
        player.currentTime = NSTimeInterval(scrubSlider.value)
        
        
        
    }
    @IBAction func shuffle(sender: AnyObject) {
        let rand = arc4random_uniform(UInt32(list.count))
        print(rand)
        var music = list[Int(rand)]
        
        let audioPath = NSBundle.mainBundle().pathForResource(music, ofType: "wav")!
        
        do {
            
            try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            
            player.play()
            
        } catch {
            print("error")
        }
    }
    @IBAction func play(sender: AnyObject) {
        
        let rand = arc4random_uniform(UInt32(list.count))
        music = list[Int(rand)]
        
        if nowPlaying != -1{
            music = list[nowPlaying]
        }
        
        print(music)
        
        let audioPath = NSBundle.mainBundle().pathForResource(music, ofType: "wav")!
        
        
        do {
            
            if pause == false{
                try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
            }
            
            player.play()
            
        } catch {
            print("error")
        }
        
    }
    
    @IBAction func pause(sender: AnyObject) {
        player.pause()
        pause = true
    }
    
    @IBAction func adjestVolume(sender: AnyObject) {
        
        player.volume = slider.value
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("OK")
        if playing == false{
            let rand = arc4random_uniform(UInt32(list.count))
            music = list[Int(rand)]
            
            if nowPlaying != -1{
                music = list[nowPlaying]
            }
            
            print(music)
            
            let audioPath = NSBundle.mainBundle().pathForResource(music, ofType: "wav")!
            
            
            do {
                

                try player = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))

                player.play()
                
            } catch {
                print("error")
            }
            playing = true
        }
        
        scrubSlider.maximumValue = Float(player.duration)
        
        _ = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateScrubSlider"), userInfo: nil, repeats: true)
        
    }
    
    func updateScrubSlider(){
        
        var time = Float(player.currentTime)
        
        scrubSlider.value = time
        let min = time / 60
        let sec = NSString(format: "%02d", Int(time) % 60)
        timeLabel.text = "\(music)  \(Int(min)):\(sec)"
        print(time % 60)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

