//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Ievgeniia Pavliuchyk on 29/01/2018.
//  Copyright © 2018 Ievgeniia Pavliuchyk. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioUrl : URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
       case slow = 0, fast, chipmunk, vader, echo, reverb
        //case slow, fast, chipmunk, vader, echo, reverb
        
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }

    override func viewDidLoad() {
        
        self.snailButton.contentMode = .center
        self.snailButton.imageView?.contentMode = .scaleAspectFit
        
        self.rabbitButton.contentMode = .center
        self.rabbitButton.imageView?.contentMode = .scaleAspectFit
        
        self.chipmunkButton.contentMode = .center
        self.chipmunkButton.imageView?.contentMode = .scaleAspectFit
        
        self.reverbButton.contentMode = .center
        self.reverbButton.imageView?.contentMode = .scaleAspectFit
        
        self.vaderButton.contentMode = .center
        self.vaderButton.imageView?.contentMode = .scaleAspectFit
        
        self.echoButton.contentMode = .center
        self.echoButton.imageView?.contentMode = .scaleAspectFit
        
        
        super.viewDidLoad()
        setupAudio()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

}
