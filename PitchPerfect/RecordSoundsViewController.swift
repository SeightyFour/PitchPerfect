//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Mário Rodrigues on 03/07/2017.
//  Copyright © 2017 Mário Rodrigues. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
	
	var audioRecorder: AVAudioRecorder!

	@IBOutlet weak var recordingLabel: UILabel!
	@IBOutlet weak var recordButton: UIButton!
	@IBOutlet weak var stopRecordingButton: UIButton!
	
	enum RecordingState {case recording, notRecording}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureButtonUI(.notRecording)
		//stopRecordingButton.isEnabled = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	
	// MARK: UI Functions
	
	func configureButtonUI(_ recordState: RecordingState) {
		switch(recordState) {
		case .recording:
			recordButton.isEnabled = false
			stopRecordingButton.isEnabled = true
			recordingLabel.text = "Recording in Progress"
		case .notRecording:
			recordButton.isEnabled = true
			stopRecordingButton.isEnabled = false
			recordingLabel.text = "Tap to Reccord"
			
		}
	}

	@IBAction func recordAudioButton(_ sender: UIButton) {
		configureButtonUI(.recording)
		//recordingLabel.text = "Recording in Progress"
		//stopRecordingButton.isEnabled = true
		//recordButton.isEnabled = false
		
		let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) [0] as String
		let recordingName = "recordedVoice.wav"
		let pathArray = [dirPath, recordingName]
		let filePath = URL(string: pathArray.joined(separator: "/"))
		print(filePath!)
		
		let session = AVAudioSession.sharedInstance()
		try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
		
		try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
		audioRecorder.delegate = self
		audioRecorder.isMeteringEnabled = true
		audioRecorder.prepareToRecord()
		audioRecorder.record()
	}
	
	@IBAction func stopRecordingButton(_ sender: UIButton) {
		configureButtonUI(.notRecording)
		//recordButton.isEnabled = true
		//stopRecordingButton.isEnabled = false
		//recordingLabel.text = "Tap to Reccord"
		audioRecorder.stop()
		let audioSession = AVAudioSession.sharedInstance()
		try! audioSession.setActive(false)
	}
	
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		if flag {
			performSegue(withIdentifier: "stopRecording" , sender: audioRecorder.url)
		}else {
			print("recording was not successful")
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "stopRecording" {
			let playSoundsVC = segue.destination as! PlaySoundsViewController
			let recordedAudioURL = sender as! URL
			playSoundsVC.recordedAudioURL = recordedAudioURL
		}
	}


}




