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

	func vigenere(input: String, key: String) -> String {
		return "foobar"
	}

	@IBAction func inputTextChanged(sender: UITextField) {
		outputLabel.hidden = false
		outputLabel.text = vigenere(inputTextField.text, key: encKeyTextField.text)
	}

	@IBAction func encKeyChanged(sender: UITextField) {
		outputLabel.hidden = false
		outputLabel.text = vigenere(inputTextField.text, key: encKeyTextField.text)
	}

	@IBAction func modeButtonPressed(sender: UIButton) {
		if currentMode == mode.enc {
			currentMode = mode.dec
			sender.setTitle("Decrypt", forState: UIControlState.Normal)
			outputLabel.text = vigenere(inputTextField.text, key: encKeyTextField.text)
		} else {
			currentMode = mode.enc
			sender.setTitle("Encrypt", forState: UIControlState.Normal)
			outputLabel.text = vigenere(inputTextField.text, key: encKeyTextField.text)
		}
	}
}

