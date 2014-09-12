//
//  SecondViewController.swift
//  Kryptomate
//
//  Created by Kilian Koeltzsch on 12/09/14.
//  Copyright (c) 2014 Kilian Koeltzsch. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

	@IBOutlet weak var inputTextField: UITextField!
	@IBOutlet weak var encKeyTextField: UITextField!
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
		func crypt() -> Int {
			switch self {
			case .enc:
				return 1;
			case .dec:
				return -1;
			}
		}
	}

	var currentMode = mode.enc	

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func vigenere(input: NSString, key: NSString, crypt: Int) -> String {
		var output = ""
		var a: Int
		var k: Int

		if (input.length == 0 || key.length == 0) {
			return ""
		}

		for i in 0..<input.length {
			a = Int(input.characterAtIndex(i))
			k = crypt * (key.characterAtIndex(i % key.length) - 65)
			if (a < 65 || a > 122 || (a > 90 && a < 97)) { // Non-Alphabetical
				output.append(Character(UnicodeScalar(a)))
			} else if (a >= 65 && a <= 90) { // Uppercase
				a += k
				if (a < 65) { a += 26 }
				if (a > 90) { a -= 26 }
				output.append(Character(UnicodeScalar(a)))
			} else { // Lowercase
				a += k
				if (a < 97)  { a += 26 }
				if (a > 122) { a -= 26 }
				output.append(Character(UnicodeScalar(a)))
			}
		}

		return output
	}

	@IBAction func inputTextChanged(sender: UITextField) {
		outputLabel.hidden = false
		outputLabel.text = vigenere(inputTextField.text, key: encKeyTextField.text, crypt: currentMode.crypt())
	}

	@IBAction func encKeyChanged(sender: UITextField) {
		encKeyTextField.text = encKeyTextField.text.uppercaseString
		outputLabel.hidden = false
		outputLabel.text = vigenere(inputTextField.text, key: encKeyTextField.text, crypt: currentMode.crypt())
	}

	@IBAction func modeButtonPressed(sender: UIButton) {
		if currentMode == mode.enc {
			currentMode = mode.dec
			sender.setTitle("Decrypt", forState: UIControlState.Normal)
			outputLabel.text = vigenere(inputTextField.text, key: encKeyTextField.text, crypt: currentMode.crypt())
		} else {
			currentMode = mode.enc
			sender.setTitle("Encrypt", forState: UIControlState.Normal)
			outputLabel.text = vigenere(inputTextField.text, key: encKeyTextField.text, crypt: currentMode.crypt())
		}
	}
}

