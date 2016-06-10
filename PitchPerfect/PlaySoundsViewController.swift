//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Stephanie Kirtiadi on 6/9/16.
//  Copyright © 2016 Cmdrtorefresh. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var recordedAudioURL: NSURL!
    
    @IBOutlet weak var snailBtnOutlet: UIButton!
    @IBOutlet weak var rabbitBtnOutlet: UIButton!
    @IBOutlet weak var chipmunkBtnOutlet: UIButton!
    @IBOutlet weak var darthVaderBtnOutlet: UIButton!
    @IBOutlet weak var echoBtnOutlet: UIButton!
    @IBOutlet weak var reverbBtnOutlet: UIButton!
    @IBOutlet weak var stopBtnOutlet: UIButton!
    
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    
    enum buttonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }
    
    @IBAction func playSoundForButton(sender: UIButton){
        switch (buttonType(rawValue: sender.tag)!){
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: AnyObject){
        stopAudio()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.NotPlaying)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
