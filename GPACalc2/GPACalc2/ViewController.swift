//
//  ViewController.swift
//  GPACalc2
//
//  Created by Rob on 2/14/16.
//  Copyright © 2016 Rob. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //UI Components: TextFields, Lables etc...
    @IBOutlet weak var crsTitle: UITextField!
    @IBOutlet weak var assTypePts: UITextField!
    @IBOutlet weak var assTypeMax: UITextField!
    @IBOutlet weak var assTypeWeight: UITextField!
    
    @IBOutlet weak var midTermPts: UITextField!
    @IBOutlet weak var midTermMax: UITextField!
    @IBOutlet weak var midTermWeight: UITextField!
    
    @IBOutlet weak var finalPts: UITextField!
    @IBOutlet weak var finalMax: UITextField!
    @IBOutlet weak var finalPrc: UITextField!
    @IBOutlet weak var numCreds: UITextField!
    
    //Course Labels
    @IBOutlet weak var LCrs1: UILabel!
    @IBOutlet weak var LCrs2: UILabel!
    @IBOutlet weak var LCrs3: UILabel!
    @IBOutlet weak var LCrs4: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Buttons:: add and deletecourse
    @IBAction func addCrs(sender: UIButton) {
        
        print("Add Test")
    }
    @IBAction func delCrs(sender: UIButton) {
        print("Delete Test")
    }
    
    
    
    


}

