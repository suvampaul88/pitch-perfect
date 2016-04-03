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
        try! audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, fileTypeHint: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        try! audioFile = AVAudioFile(forWriting: receivedAudio.filePathUrl, settings: [:])
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
        audioPlayer.currentTime = 0.0
        audioPlayer.rate = rate
        
        audioPlayer.play()
    }
    
    
    
    
    @IBAction func StopAudio(sender: UIButton) {
        stopAudioPlayerandEngine()
    }
    

    
}
