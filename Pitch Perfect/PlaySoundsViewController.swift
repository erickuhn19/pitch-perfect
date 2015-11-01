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

    
    @IBAction func playSlow(sender: UIButton) {
        playAudioWithVariableRate(0.5)
    }
    
    @IBAction func playFast(sender: UIButton) {
        playAudioWithVariableRate(1.5)
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)

    }
    

    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariableRate(rate: Float) {
        stopPlayerAndEngine()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        stopPlayerAndEngine()
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
    
    func stopPlayerAndEngine() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    @IBAction func stopPlayingSound(sender: UIButton) {
        stopPlayerAndEngine()
    }
    



}
