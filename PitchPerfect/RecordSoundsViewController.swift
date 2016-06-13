//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Stephanie Kirtiadi on 6/8/16.
//  Copyright © 2016 Cmdrtorefresh. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordBtnOutlet: UIButton!
    @IBOutlet weak var stopRecordBtnOutlet: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    @IBAction func recordBtnAction(sender: AnyObject) {
        
        configureView(isRecording: true)

        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    func configureView(isRecording recording: Bool) {
        recordBtnOutlet.enabled = !recording
        stopRecordBtnOutlet.enabled = recording
        recordingLabel.text = recording ? "Recording In Progress" : "Tap To Record"
     }
    
    @IBAction func stopRecordBtnAction(sender: AnyObject) {
        configureView(isRecording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if (flag) {
            self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            print ("Saving of recording failed")
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        stopRecordBtnOutlet.enabled = false
    }
    
}

