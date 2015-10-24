//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Eric Kuhn on 10/22/15.
//  Copyright © 2015 Eric Kuhn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    
    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        // hide the stop button
        stopButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden = true
    }

    
    @IBAction func recordAudio(sender: UIButton) {
        stopButton.hidden = false
        recordingInProgress.hidden = false
        //TODO: record the users voice
        print("record in audio")
    }

}

