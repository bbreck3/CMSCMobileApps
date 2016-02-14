//
//  ViewController.swift
//  GPACalc
//
//  Created by Rob on 2/12/16.
//  Copyright © 2016 Rob. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //UI Components
    
    @IBOutlet weak var crsTitle: UITextField!
    @IBOutlet weak var assTypePts: UITextField!
    @IBOutlet weak var assTypeMax: UITextField!
    @IBOutlet weak var assTypeWeight: UITextField!
    @IBOutlet weak var midTermPts: UITextField!
    @IBOutlet weak var midTermMax: UITextField!
    @IBOutlet weak var midTermWeight: UITextField!
    @IBOutlet weak var finalPts: UITextField!
    @IBOutlet weak var finalMax: UITextField!
    @IBOutlet weak var finalWeight: UITextField!
    @IBOutlet weak var numCredits: UITextField!
    
    @IBOutlet weak var crsInfo1: UILabel!
    @IBOutlet weak var crsInfo2: UILabel!
    @IBOutlet weak var crsInfo3: UILabel!
    @IBOutlet weak var crsInfo4: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        }
    
    
    //add course infp to label in clip board
    @IBAction func addCrs(sender: UIButton) {
        
        print("Testing Add")
    }
    
    //delete course infp to label in clip board
    @IBAction func deleteCrs(sender: UIButton) {
        
        print("Testing Add")
    }
    
}