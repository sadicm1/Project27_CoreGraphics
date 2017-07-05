//
//  ViewController.swift
//  Project27
//
//  Created by Mehmet Sadıç on 04/07/2017.
//  Copyright © 2017 Mehmet Sadıç. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  
  // Each drawing will be assigne with a number
  var currentDrawingNumber = 0

  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Start program bu drawing a rectangle
    drawRectangle()
  }

  /* Change the drawing every time redraw button is tapped */
  @IBAction func redrawTapped(_ sender: UIButton) {
    // Increment drawing number to pass the next drawing
    currentDrawingNumber += 1
    
    // Max number of drawings is 5. After 5 it is reset to 0
    if currentDrawingNumber > 6 {
      currentDrawingNumber = 0
    }
    
    // For each value of currentDrawingNumber call a different function of drawing
    switch currentDrawingNumber {
    case 0:
      drawRectangle()
      
    case 1:
      drawCircle()
      
    case 2:
      drawSketchboard()
      
    case 3:
      drawRotatedSquares()
      
    case 4:
      drawRotatedLines()
      
    case 5:
      drawImageAndText()
    case 6:
      drawAnInterstingShape()
      
    default:
      break
    }
  }
  
  /* Draw a rectangle */
  private func drawRectangle() {
    // Create the renderer
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    // Take the image from renderer
    let img = renderer.image { ctx in
      ctx.cgContext.setFillColor(UIColor.red.cgColor)
      ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
      ctx.cgContext.setLineWidth(10)
      
      ctx.cgContext.addRect(CGRect(x: 0, y: 0, width: 512, height: 512))
      ctx.cgContext.drawPath(using: .fillStroke)
    }
    
    // Set imgaView's image value to newly rendered image
    imageView.image = img
  }
  
  /* Draw a circle */
  private func drawCircle() {
    // Create the renderer
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    // Take the image from renderer
    let img = renderer.image { ctx in
      ctx.cgContext.setFillColor(UIColor.brown.cgColor)
      ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
      ctx.cgContext.setLineWidth(10)
      
      ctx.cgContext.addEllipse(in: CGRect(x: 5, y: 5, width: 502, height: 502))
      ctx.cgContext.drawPath(using: .fillStroke)
    }
    
    // Set imgaView's image value to newly rendered image
    imageView.image = img
  }
  
  /* Draw a sketch board */
  private func drawSketchboard() {
    // Create the renderer
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    // Take the image from renderer
    let img = renderer.image { ctx in
      ctx.cgContext.setFillColor(UIColor.black.cgColor)
      
      for row in 0..<8 {
        for col in 0..<8 {
          
          if (row + col) % 2 == 0 {
            ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
          }
          
        }
      }

    }
    
    // Set imgaView's image value to newly rendered image
    imageView.image = img
  }
  
  /* Draw rotated squares */
  private func drawRotatedSquares() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      
      ctx.cgContext.translateBy(x: 256, y: 256)
      
      let length = 16
      let amountOfRotate = CGFloat.pi / CGFloat(length)
      
      for _ in 0..<16 {
        ctx.cgContext.rotate(by: amountOfRotate)
        ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
      }
      
      ctx.cgContext.strokePath()
    }
    
    imageView.image = img
  }
  
  /* Draw rotated lines */
  private func drawRotatedLines() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      
      var first = true
      var length: CGFloat = 256
      
      ctx.cgContext.translateBy(x: 256, y: 256)
      
      for _ in 0..<Int(length) {
        
        ctx.cgContext.rotate(by: CGFloat.pi / 2)
        
        if first {
          ctx.cgContext.move(to: CGPoint(x: length, y: 50))
          first = false
          
        } else {
          ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
        }
        
        length *= 0.99
      }
      
      ctx.cgContext.strokePath()
    }
    
    imageView.image = img
  }
  
  /* Draw image and text */
  private func drawImageAndText() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      
      let font = UIFont(name: "Arial", size: 36)!
      
      let attrs = [NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName: font]
      
      let string: NSString = "How are you man. what are you doing\nthere tell me please."
      string.draw(with: CGRect(x: 16, y: 16, width: 400, height: 400), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
      
      let mouse = UIImage(named: "mouse")
      mouse?.draw(in: CGRect(x: 200, y: 200, width: 200, height: 300))
      
    }
    
    imageView.image = img
  }
  
  private func drawAnInterstingShape() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
    
    let img = renderer.image { ctx in
      
      let rotationAmount: CGFloat = 16
      var sideLength: CGFloat = 400
      let mouseScale: CGFloat = 7
      let numberOfSquares = 20
      
      ctx.cgContext.setLineWidth(2)
      ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
      ctx.cgContext.translateBy(x: 256, y: 256)
      
      for _ in 0..<numberOfSquares {
        
        let size = CGSize(width: sideLength, height: sideLength)
        let origin = CGPoint(x: -sideLength / 2.0, y: -sideLength / 2.0)
        
        ctx.cgContext.addRect(CGRect(origin: origin, size: size))
        
        let mouse = UIImage(named: "mouse")!
        let mouseSize = CGSize(width: size.width / mouseScale, height: size.height / mouseScale)
        mouse.draw(in: CGRect(origin: origin, size: mouseSize))
        
        ctx.cgContext.rotate(by: CGFloat.pi / rotationAmount)

        sideLength *= 0.85

      }
      
      ctx.cgContext.strokePath()
    }
    
    imageView.image = img
  
  }
  

}

