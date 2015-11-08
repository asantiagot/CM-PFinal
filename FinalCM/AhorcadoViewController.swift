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
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    let ahorcadoXML = AhorcadoXMLParser()
    
    // MARK: METHODS

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationItem.title = "Ahorcado"
        
        // Getting text for wordLabel and categoryLabel from Server
        ahorcadoXML.parseXML()
        categoryLabel.text = String(ahorcadoXML.elements.objectForKey("CATEGORIA")!)
        wordLabel.text = String(ahorcadoXML.elements.objectForKey("PALABRA")!)
        
        /*
        categoryLabel.text = ahorcadoXML.elements.objectForKey("CATEGORIA") as? String      // nil
        wordLabel.text = ahorcadoXML.elements.objectForKey("PALABRA") as? String            // nil
        */
    }
}