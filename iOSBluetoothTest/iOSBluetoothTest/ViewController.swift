//
//  ViewController.swift
//  iOSBluetoothTest
//
//  Created by Carlos Alonso on 01/10/2014.
//  Copyright (c) 2014 MyDrive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var textView: UITextView!
  var peripheral : Peripheral?
  var central : Central?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //peripheral = Peripheral()
    central = Central(textView: textView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func restart(sender: AnyObject) {
    central!.restart()
  }

  
}

