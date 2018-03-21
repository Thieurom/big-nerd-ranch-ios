//
//  DrawView.swift
//  TouchTracker
//
//  Created by Doan Le Thieu on 3/21/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var currentLines = [NSValue: Line]()
    var finishedLines = [Line]()
    
    @IBInspectable var finishedLineColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = .red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        finishedLineColor.setStroke()
        for line in finishedLines {
            stroke(line)
        }
        
        currentLineColor.setStroke()
        for (_, line) in currentLines {
            stroke(line)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let location = touch.location(in: self)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = location
        }
        
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            
            if var line = currentLines[key] {
                let location = touch.location(in: self)
                line.end = location
                
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }

        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        currentLines.removeAll()
        setNeedsDisplay()
    }
    
    func stroke(_ line: Line) {
        let path = UIBezierPath()
        path.lineWidth = lineThickness
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
}
