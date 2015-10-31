//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Eric Kuhn on 10/25/15.
//  Copyright © 2015 Eric Kuhn. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = try!
            AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl);
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions:AVAudioSessionCategoryOptions.DefaultToSpeaker)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playSlow(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playFast(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0 
        audioPlayer.play() 
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        audioPlayer.stop()
        playAudioWithVariablePitch(1000)

    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        audioPlayer.stop()
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    
    @IBAction func stopPlayingSound(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
    }
    



}
