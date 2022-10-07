//
//  SoundPlayer.swift
//  Devote
//
//  Created by Богдан Беннер on 7.10.22.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
	if let path = Bundle.main.path(forResource: sound, ofType: type) {
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: URL(filePath: path))
			audioPlayer?.play()
		} catch {
			print("Error getting the sound \(error)")
		}
	}
}
