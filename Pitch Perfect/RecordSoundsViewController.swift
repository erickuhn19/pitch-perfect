//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Eric Kuhn on 10/22/15.
//  Copyright © 2015 Eric Kuhn. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    var alertController:UIAlertController!
    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var tapToRecord: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
        tapToRecord.hidden = false 
    }


    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }

    
    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false
        recordingInProgress.hidden = false
        tapToRecord.hidden = true
        recordButton.enabled = false
        //TODO: record the users voice
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag) {
            //TODO: step 1 save the recorded audio
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            //TODO: step 2 move to the next scene aka perform seugue
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
            alertController = UIAlertController(title: "Recording Unsuccessful", message: "Try it again", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "Sure, why not!", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data 
        }
    }

}

