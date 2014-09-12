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

	func encryptCaesar(input: String, encDepth: Int) -> String {
		return "foobar"
	}

	func decryptCaesar(input: String, encDepth: Int) -> String {
		return "barbaz"
	}

	@IBAction func inputTextChanged(sender: UITextField) {
		outputLabel.hidden = false
		outputLabel.text = encryptCaesar(inputTextField.text, encDepth: depth)
	}
	
	@IBAction func depthChanged(sender: UISlider) {
		depth = Int(floor(sender.value))
		encButton.setTitle("\(currentMode.description()) (\(depth))", forState: UIControlState.Normal)
	}

	@IBAction func modeButtonPressed(sender: UIButton) {
		if currentMode == mode.enc {
			currentMode = mode.dec
			sender.setTitle("\(currentMode.description()) (\(depth))", forState: UIControlState.Normal)
			outputLabel.text = decryptCaesar(inputTextField.text, encDepth: depth)
		} else {
			currentMode = mode.enc
			sender.setTitle("\(currentMode.description()) (\(depth))", forState: UIControlState.Normal)
			outputLabel.text = encryptCaesar(inputTextField.text, encDepth: depth)
		}
	}

}

