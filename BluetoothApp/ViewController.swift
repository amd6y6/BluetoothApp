//
//  ViewController.swift
//  BluetoothApp
//
//  Created by Austin Dotto on 7/30/18.
//  Copyright © 2018 Austin Dotto. All rights reserved.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate {

  
    
    var manager : CBCentralManager?
    var names : [String] = []
    var RSSIs :[NSNumber] = []
    var timer : Timer?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func refreshButton(_ sender: Any) {
        startScan()
        startTimer()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (timer) in
            self.startScan()
        })
    }
    
    func startScan() {
        names = []
        RSSIs = []
        tableView.reloadData()
        manager?.stopScan()
        manager?.scanForPeripherals(withServices: nil, options: nil)
    }
    
   
  
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if let name = peripheral.name {
            
            // test if the same device is being returned multiple times
            
            guard !names.contains(name) else { return }
            
            // if there is a name append it to the array
            
            names.append(name)
            
        } else {
            
            // there is no name so we use the UUID
   
            guard !names.contains(peripheral.identifier.uuidString) else {return}
            names.append(peripheral.identifier.uuidString)
        }
        
        // send the data to the array
        
        RSSIs.append(RSSI)
        
        
        
        // reload the table
        
        tableView.reloadData()
    }
    
    
    /*
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        if let name = peripheral.name {
            names.append(name)
        } else {
            names.append(peripheral.identifier.uuidString)
        }
        RSSIs.append(RSSI)
        tableView.reloadData()
    }
    */
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
           startScan()
            startTimer()
        } else {
          let alert = UIAlertController(title: "Bluetooth not working", message: "Check your bluetooth settings", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BluetoothTableViewCell {
            cell.nameLabel.text = names[indexPath.row]
            cell.rssiLabel.text = "RSSI: \(RSSIs[indexPath.row])"
            return cell
        }
        return UITableViewCell()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

