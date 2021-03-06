//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Ievgeniia Pavliuchyk on 27/01/2018.
//  Copyright © 2018 Ievgeniia Pavliuchyk. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    //§
    var audioRecorder : AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }
    
    func configureUI( isRecording:Bool){
        recordingLabel.text = (isRecording ? "Recording in Progress" : "Tap to Record")
        stopRecordingButton.isEnabled = (isRecording ? true : false)
        recordButton.isEnabled = (isRecording ? false : true)
    }

    @IBAction func recordAudio(_ sender: Any) {
        configureUI(isRecording:true)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURL(withPathComponents: pathArray)
        print(filePath!)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        print(filePath!)
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
       configureUI(isRecording:false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try!audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: recorder.url)
        }
        else{
            print("record was not succesful")
            
            class ViewController: UIViewController {
                
                @IBAction func showAlertButtonTapped(_ sender: UIButton) {
                    
                    // create the alert
                    let alert = UIAlertController(title: "Warning", message: "Record was not succesful", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
   }
    
    override func prepare(for segue:UIStoryboardSegue , sender: Any?){
        if segue.identifier == "stopRecording"{
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioUrl = sender as! URL
            playSoundsVC.recordedAudioUrl = recordedAudioUrl
        }
    }
}

