//
//  FirstViewController.swift
//  Kryptomate
//
//  Created by Kilian Koeltzsch on 12/09/14.
//  Copyright (c) 2014 Kilian Koeltzsch. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var inputTextField: UITextField!
	@IBOutlet weak var encDepthSlider: UISlider!
	@IBOutlet weak var encButton: UIButton!
	@IBOutlet weak var outputTextView: UITextView!

	enum mode {
		case enc, dec
		func description() -> String {
			switch self {
			case .enc:
//				return "Current mode: Encrypt"
				return NSLocalizedString("CURRENT_MODE",comment:"Current mode") + ": " + NSLocalizedString("ENCRYPT", comment: "Encrypt")
			case .dec:
				return NSLocalizedString("CURRENT_MODE",comment:"Current mode") + ": " + NSLocalizedString("DECRYPT", comment: "Decrypt")
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

		if (input.length == 0) {
			return ""
		}

		for i in 0..<input.length {
			a = Int(input.characterAtIndex(i))
			if (a < 65 || a > 122 || (a > 90 && a < 97)) { // Non-Alphabetical
				output.append(Character(UnicodeScalar(a)))
			} else if (a >= 65 && a <= 90) { // Uppercase
				a += encDepth
				if (a < 65) { a += 26 }
				if (a > 90) { a -= 26 }
				output.append(Character(UnicodeScalar(a)))
			} else { // Lowercase
				a += encDepth
				if (a < 97) { a += 26 }
				if (a > 122) { a -= 26 }
				output.append(Character(UnicodeScalar(a)))
			}
		}

		return output
	}

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	@IBAction func inputTextChanged(sender: UITextField) {
		outputTextView.text = caesar(inputTextField.text, encDepth: depth * currentMode.crypt())
	}

	@IBAction func depthChanged(sender: UISlider) {
		depth = Int(floor(sender.value))
		encButton.setTitle("\(currentMode.description()) (\(depth))", forState: UIControlState.Normal)
		outputTextView.text = caesar(inputTextField.text, encDepth: depth * currentMode.crypt())
	}

	@IBAction func modeButtonPressed(sender: UIButton) {
		if currentMode == mode.enc {
			currentMode = mode.dec
			sender.setTitle("\(currentMode.description()) (\(depth))", forState: UIControlState.Normal)
			outputTextView.text = caesar(inputTextField.text, encDepth: depth * currentMode.crypt())
		} else {
			currentMode = mode.enc
			sender.setTitle("\(currentMode.description()) (\(depth))", forState: UIControlState.Normal)
			outputTextView.text = caesar(inputTextField.text, encDepth: depth * currentMode.crypt())
		}
	}

}

