//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by john bateman on 3/6/15.
//  Copyright (c) 2015 John Bateman. All rights reserved.
//
import AVFoundation
import UIKit


class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    @IBOutlet var stopPlaybackButton: UIButton!
    @IBOutlet var playbackInstructions: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopPlaybackButton.hidden = true
        
        // Initialize audio assets
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func viewWillAppear(animated: Bool) {
        playbackInstructions.text = String("Select a Button to Play Audio")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Play recorded audio at reduced rate.
    @IBAction func playSoundSlow(sender: UIButton) {
        self.stopPlaybackButton.hidden = false;
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        playAudio(0.75)
        playbackInstructions.text = String("Select the Stop Button to Halt Audio")
    }
    
    // Play recorded audio at increased rate.
    @IBAction func playSoundFast(sender: UIButton) {
        self.stopPlaybackButton.hidden = false;
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        playAudio(2.0)
        playbackInstructions.text = String("Select the Stop Button to Halt Audio")
    }
    
    // Halt Playback of recorded audio.
    @IBAction func stopAudioPlayback(sender: UIButton) {
        stopPlaybackButton.hidden = true;
        audioPlayer.stop()
        audioEngine.stop()
        playbackInstructions.text = String("Select a Button to Play Audio")
    }
    
    // Play recorded audio with increased pitch.
    @IBAction func playChipmunkAudio(sender: UIButton) {
        stopPlaybackButton.hidden = false;
        playAudioWithVariablePitch(1000)
        playbackInstructions.text = String("Select the Stop Button to Halt Audio")
    }
    
    // Play recorded audio with decreased pitch.
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        stopPlaybackButton.hidden = false;
        playAudioWithVariablePitch(-1000)
        playbackInstructions.text = String("Select the Stop Button to Halt Audio")
    }

    // Play recorded audio using the AVAudioPlayer.
    func playAudio(speed:Float) -> Void {
        audioPlayer.stop()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    // Play recorded audio using the AVAudioEngine.
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
}
