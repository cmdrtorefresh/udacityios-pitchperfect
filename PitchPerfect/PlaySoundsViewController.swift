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
    @IBOutlet weak var durationOutlet: UILabel!
    
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: NSTimer!
    var duration: Double!
    
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
        duration = getOriginalAudioDuration(recordedAudioURL)
        let durationStringArray = doubleFigureFormatter(duration, noBehindDecimal: 3)
        durationOutlet.text = durationStringArray[0] + durationStringArray[1] + " sec"
    }

    func doubleFigureFormatter(number: Double, noBehindDecimal: Int) -> [String] {
        let fullNumber = Double(Int(number))
        let unformattedDecimal = number - fullNumber
        let unformattedString = String(unformattedDecimal)
        var formattedDecimal = ""
        var index = 1
        while index <= noBehindDecimal + 1 {
            formattedDecimal += String(unformattedString[unformattedString.startIndex.advancedBy(index)])
            index += 1
        }
        return [String(Int(number)) ,formattedDecimal]
    }
    
    func getOriginalAudioDuration(fileURL: NSURL) -> Double {
        var dur: Double = 0
        do {
            dur = try AVAudioPlayer(contentsOfURL: fileURL).duration
        } catch {
            showAlert(Alerts.AudioPlayerError, message: String(error))
        }
        return dur
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
