//
//  Peripheral.swift
//  iOSBluetoothTest
//
//  Created by Carlos Alonso on 10/10/2014.
//  Copyright (c) 2014 MyDrive. All rights reserved.
//

import UIKit
import CoreBluetooth

let UUID_STRING = "A2689EFF-0C82-4655-9780-668749EF6C6E"

class Peripheral: NSObject, CBPeripheralManagerDelegate {
  
  let nameCharacteristic : CBMutableCharacteristic
  let peripheralManager : CBPeripheralManager?
  let serviceUUID : CBUUID = CBUUID.UUIDWithString(UUID_STRING)
  
  override init() {
    
    nameCharacteristic = CBMutableCharacteristic(type: serviceUUID, properties: CBCharacteristicProperties.Read, value: "Carlos Alonso".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false), permissions: CBAttributePermissions.Readable)
    var nameService = CBMutableService(type: serviceUUID, primary: true)
    nameService.characteristics = [nameCharacteristic]
    
    super.init()
    
    peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    peripheralManager!.addService(nameService)
    
    peripheralManager!.startAdvertising([ CBAdvertisementDataServiceUUIDsKey: [nameService.UUID]])
  }
  
  func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
    println("New status: \(peripheral.state)")
  }
  
  func peripheralManager(peripheral: CBPeripheralManager!, didAddService service: CBService!, error: NSError!) {
    println("Error adding service: \(error.localizedDescription)")
  }
  
  func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager!, error: NSError!) {
    println("Error advertising: \(error.localizedDescription)")
  }
  
  func peripheralManager(peripheral: CBPeripheralManager!, didReceiveReadRequest request: CBATTRequest!) {
    if request.characteristic.UUID == nameCharacteristic.UUID {
      if request.offset > nameCharacteristic.value.length {
        peripheral.respondToRequest(request, withResult: CBATTError.InvalidOffset)
      } else {
        request.value = nameCharacteristic.value.subdataWithRange(NSMakeRange(request.offset, nameCharacteristic.value.length - request.offset))
        peripheral.respondToRequest(request, withResult: CBATTError.Success)
      }
    } else {
      peripheral.respondToRequest(request, withResult: CBATTError.AttributeNotFound)
    }
  }
  
  func peripheralManager(peripheral: CBPeripheralManager!, didReceiveWriteRequests requests: [AnyObject]!) {
    peripheral.respondToRequest(requests[0] as CBATTRequest, withResult: CBATTError.WriteNotPermitted)
  }
   
}
