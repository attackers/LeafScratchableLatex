//
//  ScratchableLatexLayer.swift
//  ScratchableLatex
//
//  Created by ZZCM on 2019/1/3.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit
import CoreGraphics
public class ScratchableLatexLayer: CALayer {
    var isSelect = false
    var tag: NSInteger?
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func draw(in ctx: CGContext) {
        self.backgroundColor = UIColor.white.cgColor
        let point = CGPoint(x: self.frame.width/2.0, y: self.frame.height/2.0)
        ctx.addArc(center: point, radius: self.frame.width/2.0 - 1, startAngle: 0.0, endAngle: .pi * 2, clockwise: true)
        ctx.setLineWidth(2)
        ctx.setStrokeColor(UIColor.gray.cgColor)
        ctx.strokePath()
        ctx.saveGState()
        guard isSelect else {return}
        ctx.addArc(center: point, radius: 8, startAngle: 0.0, endAngle: .pi * 2, clockwise: true)
        ctx.setLineWidth(2)
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fillPath()
    }
}
