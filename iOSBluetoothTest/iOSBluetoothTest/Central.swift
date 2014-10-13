//
//  Central.swift
//  iOSBluetoothTest
//
//  Created by Carlos Alonso on 10/10/2014.
//  Copyright (c) 2014 MyDrive. All rights reserved.
//

import UIKit
import CoreBluetooth

class Central: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
 
  let centralManager : CBCentralManager?
  let tView : UITextView?
  
  init(textView: UITextView!) {
    super.init()
    
    tView = textView
    centralManager = CBCentralManager(delegate: self, queue: nil)
    centralManager!.scanForPeripheralsWithServices([UUID_STRING], options: nil)
  }
  
  func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
    println("Discovered \(peripheral.name)")
    dispatch_async(dispatch_get_main_queue(), {
      self.tView!.text = "\(self.tView!.text)\n \(peripheral.name): \(RSSI)"
    })
    //central.connectPeripheral(peripheral, options: nil)
  }
  
  func centralManagerDidUpdateState(central: CBCentralManager!) {
    println("Central state updated to \(central.state)")
  }
  
  func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
    println("Peripheral connected")
    peripheral.delegate = self
  }
  
  
}
