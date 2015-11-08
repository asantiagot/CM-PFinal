//
//  AhorcadoXMLParser.swift
//  FinalCM
//
//  Created by Antonio Santiago on 11/8/15.
//  Copyright © 2015 Abner Castro Aguilar. All rights reserved.
//

import Foundation

class AhorcadoXMLParser: NSXMLParser, NSXMLParserDelegate {
    
    // MARK: Attributes
    
    var posts = NSMutableArray()
    var parser = NSXMLParser()
    var elements = NSMutableDictionary()
    var element = NSString()
    var categoria = NSMutableString()
    var palabra = NSMutableString()

    
    // MARK: Methods
    
    func parseXML() {
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:"http://www.serverbpw.com/cm/2016-1/hangman.php"))!)!
        parser.delegate = self
        parser.parse()
        
        // tbData!.reloadData()  JUST IF TABLE VIEW IS USED
    }
    
    // MARK: XMLParser Methods
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        
        // TODO: Search an alternative method to get both <string> content. This one is hardcoded.
        if (elementName as NSString).isEqualToString("array") {
            elements = NSMutableDictionary()
            elements = [:]
            categoria = NSMutableString()
            categoria = ""
        }
        
        if (elementName as NSString).isEqualToString("string")
        {
            palabra = NSMutableString()
            palabra = ""
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        
        if element.isEqualToString("string") {
            categoria.appendString(string)
        }
        
        if element.isEqualToString("string") {
            palabra.appendString(string)
        }
        
        /*
        if element.isEqualToString("title") {
        title1.appendString(string)
        } else if element.isEqualToString("pubDate") {
        date.appendString(string)
        }
        */
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqualToString("array") {
            if !categoria.isEqual(nil) {
                elements.setObject(categoria, forKey: "CATEGORIA")
            }
            if !palabra.isEqual(nil) {
                elements.setObject(palabra, forKey: "PALABRA")
            }
            
            posts.addObject(elements)
        }
    }
    

}
