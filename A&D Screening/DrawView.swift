//
//  drawView.swift
//  Alzhiemer Screening
//
//  Created by Andrew Stallone on 7/4/16.
//  Copyright © 2016 Andrew Stallone. All rights reserved.
//

import UIKit

class DrawView: UIView {

    var lines: [Line] = []
    var lastPoint: CGPoint!
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
        lastPoint = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
        let newPoint = touch.location(in: self)
        lines.append(Line(start: lastPoint, end: newPoint))
        lastPoint = newPoint
            
        self.setNeedsDisplay()
        }
    }
    
    
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        for line in lines{
            context?.move(to: CGPoint(x: line.start.x, y: line.start.y))
            context?.addLine(to: CGPoint(x: line.end.x, y: line.end.y))
        }
        context?.setLineCap(CGLineCap.round)
        context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
        context?.setLineWidth(5)
        context?.strokePath()
    }

}
