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
    var category: String?
    var word: String?
    
    var images: [UIImageView]!
    
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
        
        if let strCat = Optional(ahorcadoXML.elements.objectForKey("CATEGORIA")) {
            print("Category found from XML is: \(String(strCat)) and its length is: \(String(strCat).characters.count)")
            category = String(strCat)
            categoryLabel.text = category
            
        } else {
            print("No category was found!")
        }
        
        if let strWord = Optional(ahorcadoXML.elements.objectForKey("PALABRA")) {
            // print("Word found from XML length is \(String(strWord).characters.count) characters long")
            word = String(strWord)
            wordLabel.text = word
            print("word casted to string lenth is \(word?.characters.count)")
        } else {
            print("No word was found!")
        }
        
        /*if let catOp = category {
            category = String(ahorcadoXML.elements.objectForKey("CATEGORIA")!)
            categoryLabel.text = catOp
        }
        else {
            print("category value is nil")
        }
        if let wordOp = word {
            word = String(ahorcadoXML.elements.objectForKey("PALABRA")!)
            wordLabel.text = wordOp
        }
        else {
            print("word value is nil")
        }
        */
    }

    func displayWordHidden(word: String) {
        if Optional(word) != nil {
            var i=0
            // var posX: CGFloat = self.view.frame.width/CGFloat((word.characters.count)+1)
            
            var imageRatio:CGFloat
            let letterWidth:CGFloat = self.view.frame.size.width*0.05
            var letterHeight:CGFloat
            
            let posY: CGFloat = self.view.frame.height/4
            var posX: CGFloat = (self.view.frame.width/2)-(letterWidth*CGFloat(word.characters.count))/2
            
            var firstImage: UIImageView!
            
            for letters in word.characters {
                // print("Cycle will be repeated \(word.characters.count) times")
                print("\(letters).png")
                print("Position in x is: \(posX)")
                // Preparing size and position parameters for the Image View
                if(letters != " ") {
                    firstImage = UIImageView(image: UIImage(named: "\(letters)"))
                } else {
                    firstImage = UIImageView(image: UIImage(named: "break"))
                }
                imageRatio = firstImage.frame.size.width/firstImage.frame.size.height
                letterHeight = letterWidth/imageRatio
                // print("POSITION AND SIZE VALUES ARE: \nimageRatio=\(imageRatio)\nletterWidth= \(letterWidth)\nletterHeight:\(letterHeight)")
                // Presenting Image Views
                firstImage.frame = CGRect(x: posX, y: posY, width: letterWidth, height: letterHeight)
                // firstImage.hidden = true                 // Uncomment when word is well positioned
                self.view.addSubview(firstImage)
                // images.append(UIImageView(image: UIImage(named: "\(letters)")))
                // self.view.addSubview(images[i])
                posX += (self.view.frame.width*0.001+letterWidth)
                i++
            }
        } else {
            print("No connection")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Ahorcado"
        displayWordHidden("prueba".uppercaseString)
        
        /*
        if ahorcadoXML.verifyValues() {
            fetchWords()
            if word != nil {
                displayWordHidden(word!)
            } else {
                print("No word found")
            }
        } else {
            print("Connection to the server could not be established.")
            // Cambiar este print, debe mostrar una alerta en la cual se diga que no se pudo establecer la conexión
        }
        */
        
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