//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by Eric Kuhn on 10/22/15.
//  Copyright © 2015 Eric Kuhn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func recordAudio(sender: UIButton) {
        recordingInProgress.hidden = false
        //TODO: record the users voice
        print("record in audio")
    }
    
    @IBOutlet weak var recordingInProgress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func stopButton(sender: UIButton) {
    }

}

