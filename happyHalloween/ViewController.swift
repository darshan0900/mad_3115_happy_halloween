//
//  ViewController.swift
//  happyHalloween
//
//  Created by Darshan Jain on 2022-10-31.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var emoji: UILabel!

	@IBOutlet var buttons: [UIButton]!
	
	@IBOutlet weak var pointsLabel: UILabel!
	
	@IBOutlet weak var livesLabel: UILabel!
	
	@IBOutlet weak var startButton: UIButton!
	
	@IBOutlet weak var timerLabel: UILabel!
	
	private var timer: Timer?
	private var currentCountdown: Int = 5
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		restartGame()
	}
	
	func randomizeEmoji() {
		startTimer(seconds: 5){
			self.decreaseLife()
			self.randomizeEmoji()
		}
		let (key, value) = emojiList.randomElement()!
		emoji.text = key
		let randomPos = Int.random(in: 0...3)
		var remainingData = emojiList.values.filter{$0 != value}
		for (index, button) in buttons.enumerated() {
			if index == randomPos{
				button.setTitle(value, for: .normal)
			}else{
				let randomValue = remainingData.randomElement()
				remainingData = remainingData.filter{$0 != randomValue}
				button.setTitle(randomValue, for: .normal)
			}
		}
	}
	
	
	@IBAction func onEmojiSelectionButtonPress(_ sender: UIButton) {
		endTimer()
		guard let selectedValue = sender.currentTitle else {return}
		
		let activeEmoji = emojiList.removeValue(forKey: emoji.text!)
		
		if activeEmoji == selectedValue{
			guard let currentPoints = Int(pointsLabel.text!) else {return}
			let newPoints = currentPoints + 1
			if newPoints > emojiCount {
				showAlert(title: "Congrats", message: "You won the game")
				return
			}
			pointsLabel.text = "\(newPoints)"
			randomizeEmoji()
		} else{
			decreaseLife()
		}
	}
	
	func decreaseLife() {
		guard let currentLives = Int(livesLabel.text!) else {return}
		let newLives = currentLives - 1
		if newLives > 0{
			livesLabel.text = "\(currentLives-1)"
		} else{
			showAlert(title: "Oops", message: "You lost the game")
			return
		}
		randomizeEmoji()
	}
	
	@IBAction func onStartPress(_ sender: UIButton) {
		randomizeEmoji()
		startButton.isHidden = true
		timerLabel.isHidden = false
	}
	
	func showAlert(title: String, message: String) {
		let infoAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		infoAlert.addAction(UIAlertAction(title: "Okay", style: .default))
		present(infoAlert, animated: true){
			self.restartGame()
		}
	}
	
	func restartGame() {
		timerLabel.isHidden = true
		startButton.isHidden = false
		emoji.text = "???"
		for button in buttons{
			button.setTitle("???", for: .normal)
		}
		pointsLabel.text="0"
		livesLabel.text="10"
		generateEmojiList()
		endTimer()
	}
	
	private func startTimer( seconds: Int, callback: @escaping ()->Void ){
		currentCountdown = seconds
		self.timerLabel.text="00:0\(self.currentCountdown)"
		timer?.invalidate()
		timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){_ in
			if self.currentCountdown <= 0 {
				self.endTimer()
				callback()
			} else{
				self.currentCountdown -= 1
				self.timerLabel.text="00:0\(self.currentCountdown)"
			}
		}
	}
	
	private func endTimer() {
		timer?.invalidate()
	}
	
}

