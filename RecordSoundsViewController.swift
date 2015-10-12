//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by john bateman on 3/5/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//

import AVFoundation
import UIKit

var audioRecorder:AVAudioRecorder!
var recordedAudio:RecordedAudio!

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet var recordingLabel: UILabel!
    @IBOutlet var tapToRecordLabel: UILabel!
    @IBOutlet var recordButton: UIButton!
    @IBOutlet var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true;
        recordButton.enabled = true;
        recordingLabel.hidden = true;
        tapToRecordLabel.hidden = false;
        tapToRecordLabel.text = String("Tap to Record")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Record audio captured with microphone to a file.
    @IBAction func recordAudio(sender: UIButton) {
        println("recording audio button")
        recordingLabel.hidden = false
        recordingLabel.text = String("Recording in Progress")
        stopButton.hidden = false
        recordButton.enabled = false
        tapToRecordLabel.hidden = true
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    // Halt capture of audio to file.
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = false
        tapToRecordLabel.hidden = false
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
    }

    // VAudioRecorderDelegate method is called when recording has finished. Transition to PlaySoundsVC and pass it info about the recorded audio.
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
        if(flag) {
            recordedAudio = RecordedAudio(fileURL:recorder.url, titleOfAudioFile:recorder.url.lastPathComponent!)
            
            // Trigger transition to PlaySoundsVC
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }
        else {
            println("Recording failed.")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
    }
}

