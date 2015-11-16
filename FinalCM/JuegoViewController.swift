//
//  JuegoViewController.swift
//  FinalCM
//
//  Created by Antonio Santiago on 11/15/15.
//  Copyright © 2015 Abner Castro Aguilar. All rights reserved.
//

import UIKit

class JuegoViewController: UIViewController, NSXMLParserDelegate {
    
    // MARK: ATTRIBUTES
    var images = [String]()
    var gTitle: String?
    var gDescription: String?
    var gURL: String?
    var gID: String?
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var urlAddress = NSMutableString()
    var urlString = ""
    var imageCounter = 0
    
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    
    @IBAction func differentImagePressed(sender: UIButton) {
        
        if sender.tag == 0 {                // LEFT
            if imageCounter == images.startIndex {
                imageCounter = images.endIndex-1
            } else {
                imageCounter--
            }
        } else {                            // RIGHT
            if imageCounter == images.endIndex-1 {
                imageCounter = images.startIndex
            } else {
                imageCounter++
            }
        }
        print("imageCounter value is \(imageCounter)")
        urlString = deleteUnwantedCharacters(images[imageCounter])
        gameImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: urlString)!)!)
        
    }
    
    func verifyConnection() -> Bool{
        beginParsing()
        var imagesExist = false
        if images.count > 0 {
            imagesExist = true
        } else {
            imagesExist = false
            let noConnectionAlert = UIAlertController(title: "No se han podido obtener las imágenes", message: "El servidor no está disponible o no tienes conexión a internet. Intenta más tarde.", preferredStyle: UIAlertControllerStyle.Alert)
            noConnectionAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (UIAlertAction: UIAlertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            self.presentViewController(noConnectionAlert, animated: true, completion: nil)
        }
        return imagesExist
    }
    
    // MARK: METHODS
    
    func deleteUnwantedCharacters(urlAddress: String) -> String {
        
        var finalURL = urlAddress
        finalURL.removeRange(finalURL.startIndex.advancedBy(48)..<finalURL.endIndex)
        print(finalURL)

        return finalURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = gTitle!
        
        verifyConnection()
        
        gameTitle.text = gTitle
        gameDescription.text = gDescription
        gameDescription.textAlignment = NSTextAlignment.Justified
        
        urlString = deleteUnwantedCharacters(images[imageCounter])
        gameImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: urlString)!)!)
        gameImage.contentMode = UIViewContentMode.ScaleAspectFit
    }
    
    // MARK: NSXMLParser
    
    func beginParsing() {
        posts = []
        parser = NSXMLParser(contentsOfURL: NSURL(string: "http://www.serverbpw.com/cm/2016-1/gallery.php?id=\(gID!)")!)!
        parser.delegate = self
        parser.parse()
    }
    
    // MARK: NSXMLParserDelegate Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        if (elementName as NSString).isEqualToString("string") {
            elements = NSMutableDictionary()
            elements = [:]
            urlAddress = NSMutableString()
            urlAddress = ""
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String)
    {
        if element.isEqualToString("string") {
            urlAddress.appendString(string)
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("array") {
            if !urlAddress.isEqual(nil) {
                elements.setObject(urlAddress, forKey: "URL")
                images.append(String(urlAddress))
            }
            posts.addObject(elements)
        }
    }
}
