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
    tView!.text = ""
    centralManager = CBCentralManager(delegate: self, queue: nil)
  }
  
  func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
    println("Discovered \(peripheral.name)")
    dispatch_async(dispatch_get_main_queue(), {
      self.tView!.text = "\(self.tView!.text)\n \(peripheral.name): \(RSSI)"
    })
    //central.connectPeripheral(peripheral, options: nil)
  }
  
  func centralManagerDidUpdateState(central: CBCentralManager!) {
    switch central.state {
    case CBCentralManagerState.Unknown:
      println("Central state updated to Unknown")
    case CBCentralManagerState.Resetting:
      println("Central state updated to Resetting")
    case CBCentralManagerState.Unsupported:
      println("Central state updated to Unsupported")
    case CBCentralManagerState.Unauthorized:
      println("Central state updated to Unauthorized")
    case CBCentralManagerState.PoweredOff:
      println("Central state updated to PoweredOff")
    case CBCentralManagerState.PoweredOn:
      println("Central state updated to PoweredOn")
      centralManager!.scanForPeripheralsWithServices([CBUUID.UUIDWithString(UUID_STRING)], options: nil)
    default:
      println("Central state updated to WAT??!!")
    }
  }
  
  func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
    println("Peripheral connected")
    peripheral.delegate = self
  }
  
  func restart() {
    tView!.text = ""
    centralManager!.stopScan()
    centralManager!.scanForPeripheralsWithServices([CBUUID.UUIDWithString(UUID_STRING)], options: nil)
  }
  
  
}
