//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Mário Rodrigues on 04/07/2017.
//  Copyright © 2017 Mário Rodrigues. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
	
	var recordedAudioURL: URL!
	var audioFile: AVAudioFile!
	var audioEngine: AVAudioEngine!
	var audioPlayerNode: AVAudioPlayerNode!
	var stopTimer: Timer!
	
	@IBOutlet weak var slowButton: UIButton!
	@IBOutlet weak var fastButton: UIButton!
	@IBOutlet weak var highPitchButton: UIButton!
	@IBOutlet weak var lowPitchButton: UIButton!
	@IBOutlet weak var echoButton: UIButton!
	@IBOutlet weak var reverbButton: UIButton!
	@IBOutlet weak var stopButton: UIButton!
	
	enum ButtonType: Int { case slow = 1, fast, highPitch, lowPitch, echo, reverb }
	
	@IBAction func playSoundForButton(_ sender: UIButton){
		switch (ButtonType(rawValue: sender.tag)!) {
		case .slow:
			playSound(rate: 0.5)
		case .fast:
			playSound(rate: 2.5)
		case .highPitch:
			playSound(pitch: 1500)
		case .lowPitch:
			playSound(pitch: -500)
		case .echo:
			playSound(echo: true)
		case .reverb:
			playSound(reverb: true)
		}
		
		configureUI(.playing)
	}
	
	@IBAction func stopButtonPressed(_ sender: UIButton){
		stopAudio()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setupAudio()
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureUI(.notPlaying)
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
