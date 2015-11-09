//
//  AhorcadoViewController.swift
//  FinalCM
//
//  Created by Antonio Santiago on 10/27/15.
//  Copyright © 2015 Abner Castro Aguilar. All rights reserved.
//

import UIKit

class AhorcadoViewController: UIViewController {
    
    // MARK: ATTRIBUTES
    var category = ""
    var word = ""

    let ahorcadoXML = AhorcadoXMLParser()
    
    // MARK: OUTLETS
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!

    // MARK: METHODS

    func fetchWords() {
        // Getting text for wordLabel and categoryLabel from Server
        ahorcadoXML.parseXML()
        category = String(ahorcadoXML.elements.objectForKey("CATEGORIA")!)
        word = String(ahorcadoXML.elements.objectForKey("PALABRA")!)
        categoryLabel.text = category
        wordLabel.text = word
    }
    
    func displayWord() {
        for character in word.characters {
            var character = UIImage(named: "\(character).png")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Ahorcado"
        fetchWords()
    }
    
    // MARK: ACTIONS
    
    @IBAction func aPressed(sender: UIButton) {
        aButton.enabled = false
    }
    @IBAction func bPressed(sender: UIButton) {
        bButton.enabled = false
    }
    @IBAction func cPressed(sender: UIButton) {
    }
    @IBAction func dPressed(sender: UIButton) {
    }
    @IBAction func ePressed(sender: UIButton) {
    }
    @IBAction func fPressed(sender: UIButton) {
    }
    @IBAction func gPressed(sender: UIButton) {
    }
    @IBAction func hPressed(sender: UIButton) {
    }
    @IBAction func iPressed(sender: UIButton) {
    }
    @IBAction func jPressed(sender: UIButton) {
    }
    @IBAction func kPressed(sender: UIButton) {
    }
    @IBAction func lPressed(sender: UIButton) {
    }
    @IBAction func mPressed(sender: UIButton) {
    }
    @IBAction func nPressed(sender: UIButton) {
    }
    @IBAction func niPressed(sender: UIButton) {
    }
    @IBAction func oPressed(sender: UIButton) {
    }
    @IBAction func pPressed(sender: UIButton) {
    }
    @IBAction func qPressed(sender: UIButton) {
    }
    @IBAction func rPressed(sender: UIButton) {
    }
    @IBAction func sPressed(sender: UIButton) {
    }
    @IBAction func tPressed(sender: UIButton) {
    }
    @IBAction func uPressed(sender: UIButton) {
    }
    @IBAction func vPressed(sender: UIButton) {
    }
    @IBAction func wPressed(sender: UIButton) {
    }
    @IBAction func xPressed(sender: UIButton) {
    }
    @IBAction func yPressed(sender: UIButton) {
    }
    @IBAction func zPressed(sender: UIButton) {
    }
}