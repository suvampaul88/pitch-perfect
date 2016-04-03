//
//  PlaySoundViewController.swift
//  pitch perfect
//
//  Created by Suvam Paul on 4/3/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundViewController: UIViewController {
    
    @IBOutlet weak var playSoundSlow: UIButton!
    @IBOutlet weak var playSoundFast: UIButton!
    @IBOutlet weak var playSoundChip: UIButton!
    @IBOutlet weak var playSoundDarth: UIButton!
    
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
    }
    
    

    
    @IBAction func playSlowAudio(sender: UIButton) {
        playAudioWithVariableRate(0.5)
        
    }
    
    
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithVariableRate(2.0)
    }
    
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func PlayDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    
    func stopAudioPlayerandEngine(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    
    func playAudioWithVariablePitch(pitch: Float) {
        stopAudioPlayerandEngine()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
    
    
    
    func playAudioWithVariableRate(rate: Float) {
        stopAudioPlayerandEngine()

        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
    
        audioPlayer.play()
    }
    
    
    
    
    @IBAction func StopAudio(sender: UIButton) {
        stopAudioPlayerandEngine()
    }
    

    
}
