//
//  FirstViewController.swift
//  Kryptomate
//
//  Created by Kilian Koeltzsch on 12/09/14.
//  Copyright (c) 2014 Kilian Koeltzsch. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

	@IBOutlet weak var inputTextField: UITextField!
	@IBOutlet weak var encDepthSlider: UISlider!
	@IBOutlet weak var encButton: UIButton!
	@IBOutlet weak var outputLabel: UILabel!

	enum mode {
		case enc, dec
		func description() -> String {
			switch self {
			case .enc:
				return "Encrypt"
			case .dec:
				return "Decrypt"
			}
		}
	}

	var currentMode = mode.enc
	var depth = 10

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func caesar(input: NSString, encDepth: Int) -> String {
		var output = ""
		var a: Int

		for i in 1..<input.length {
			a = Int(input.characterAtIndex(i))
			if (a < 65 || a > 122 || (a > 90 && a < 97)) { // Non-Alphabetical
				// TODO: Converting ints to chars/strings in Swift?
			} else if (a >= 65 && a <= 90) { // Uppercase
				a += encDepth
				if (a < 65) { a += 26 }
				if (a > 90) { a -= 26 }
				// TODO: Append the char representation of a to output here as well
			} else { // Lowercase
				a += encDepth
				if (a < 97) { a += 26 }
				if (a > 122) { a -= 26 }
				// TODO: Append the char representation of a to output here as well
			}
		}

		return output
	}

	@IBAction func inputTextChanged(sender: UITextField) {
		outputLabel.hidden = false
		outputLabel.text = caesar(inputTextField.text, encDepth: depth)
	}
	
	@IBAction func depthChanged(sender: UISlider) {
		depth = Int(floor(sender.value))
		encButton.setTitle("\(currentMode.description()) (\(depth))", forState: UIControlState.Normal)
	}

	@IBAction func modeButtonPressed(sender: UIButton) {
		if currentMode == mode.enc {
			currentMode = mode.dec
			sender.setTitle("\(currentMode.description()) (\(depth))", forState: UIControlState.Normal)
			outputLabel.text = caesar(inputTextField.text, encDepth: depth)
		} else {
			currentMode = mode.enc
			sender.setTitle("\(currentMode.description()) (\(depth))", forState: UIControlState.Normal)
			outputLabel.text = caesar(inputTextField.text, encDepth: depth)
		}
	}

}

