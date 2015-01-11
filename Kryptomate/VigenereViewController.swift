//
//  SecondViewController.swift
//  Kryptomate
//
//  Created by Kilian Koeltzsch on 12/09/14.
//  Copyright (c) 2014 Kilian Koeltzsch. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var inputTextField: UITextField!
	@IBOutlet weak var encKeyTextField: UITextField!
	@IBOutlet weak var encButton: UIButton!
	@IBOutlet weak var outputTextView: UITextView!

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

	func vigenere(input: NSString, key: NSString) -> String {
		var output = ""
		var a: Int
		var k: Int

		if (input.length == 0 || key.length == 0) {
			return ""
		}

		for i in 0..<input.length {
			a = Int(input.characterAtIndex(i))
			k = currentMode.crypt() * (key.characterAtIndex(i % key.length) - 65)
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

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}

	func checkEncryptionString(originalstring: String) -> NSString {
		// Encryptionstring is allcaps
		var newstring = originalstring.uppercaseString
		// and contains no spaces
		newstring = newstring.stringByReplacingOccurrencesOfString(" ", withString: "")
		// no numbers either
		if let match = newstring.rangeOfString("\\d", options: .RegularExpressionSearch) {
			// since the number should just be typed, we should get away with
			// removing the last char in the string
			let stringLength = countElements(newstring)
			let substringIndex = stringLength - 1
			newstring = newstring.substringToIndex(advance(newstring.startIndex, substringIndex))
		}
		return newstring
	}

	@IBAction func inputTextChanged(sender: UITextField) {
		outputTextView.text = vigenere(inputTextField.text, key: encKeyTextField.text)
	}

	@IBAction func encKeyChanged(sender: UITextField) {
		encKeyTextField.text = checkEncryptionString(encKeyTextField.text)
		outputTextView.text = vigenere(inputTextField.text, key: encKeyTextField.text)
	}

	@IBAction func modeButtonPressed(sender: UIButton) {
		if currentMode == mode.enc {
			currentMode = mode.dec
			sender.setTitle("Current Mode: Decrypt", forState: UIControlState.Normal)
			outputTextView.text = vigenere(inputTextField.text, key: encKeyTextField.text)
		} else {
			currentMode = mode.enc
			sender.setTitle("Current Mode: Encrypt", forState: UIControlState.Normal)
			outputTextView.text = vigenere(inputTextField.text, key: encKeyTextField.text)
		}
	}
}

