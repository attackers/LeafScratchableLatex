//
//  ScratchableLatexView.swift
//  ScratchableLatex
//
//  Created by ZZCM on 2019/1/3.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit

public enum ScratchableLatexType {
    
    /// 保存解锁手势
    case save_ScratchableLatexType
    /// 修改解锁手势
    case change_ScratchableLatexType
    /// 手势登录
    case login_ScratchableLatexType
    /// 删除手势
    case delete_ScratchableLatexType

}
public typealias ScratchableLatexStatus = (_ type: ScratchableLatexType,_ verity: Bool,_ verifyNumber: NSInteger) -> Void
public class ScratchableLatexView: UIView {
    
    let key_ScratchableLatex = "ScratchableLatex"

    var drawPoins =  [CGPoint]()
    var basePoins =  [CGPoint]()
    var type = ScratchableLatexType.save_ScratchableLatexType
    var verifyNumber = 0
    
    var scratchableLatexStatus: ScratchableLatexStatus?
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        let width = frame.width/5.0
        let leftX = 10.0
        let cententX = frame.width/2.0 - 45
        let rightX = frame.width - width - 25.0
        let section = frame.width - width * 3 - 35
        var y = 100.0
        for i in 0 ..< 9 {
            let layerScratchable = ScratchableLatexLayer()
            switch i%3 {
            case 0:
                layerScratchable.frame = CGRect(x: leftX, y: Double(y), width: 90.0, height: 90.0)
            case 1:
                layerScratchable.frame = CGRect(x: Double(cententX), y: y, width: 90.0, height: 90.0)
            case 2:
                layerScratchable.frame = CGRect(x: Double(rightX), y: y, width: 90.0, height: 90.0)
            default:
                break
            }
            layer.addSublayer(layerScratchable)
            layerScratchable.setNeedsDisplay()
            if i == 2 || i == 5{
                y = Double(layerScratchable.frame.maxY + section/2.0)
            }
        }
    }

    override public func draw(_ layer: CALayer, in ctx: CGContext) {
        self.backgroundColor = UIColor.white
        guard !(drawPoins.isEmpty) else {
            return
        }
        ctx.move(to: (drawPoins.first)!)
        for i in  1 ..< drawPoins.count{
            ctx.addLine(to: (drawPoins[i]))
        }
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.strokePath()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension ScratchableLatexView {
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !drawPoins.isEmpty {
            drawPoins.removeAll()
            _ = layer.sublayers?.map({ clayer in
                let bLayer = clayer as? ScratchableLatexLayer
                bLayer?.isSelect = false
                bLayer!.setNeedsDisplay()

            })
        }
        layer.setNeedsDisplay()
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first

       _ = layer.sublayers?.map({ cLayer in
            let bLayer = cLayer as? ScratchableLatexLayer
            let thisIn1 =  bLayer!.frame.contains((touch?.location(in: self))!)
            if thisIn1 {
                bLayer!.isSelect = true
                bLayer!.setNeedsDisplay()
                if !drawPoins.contains(bLayer!.position) {
                     drawPoins.append(bLayer!.position)
                }
            }
        })
        
        layer.setNeedsDisplay()
    }
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch type {
        case .change_ScratchableLatexType:
            changeScratchableLatex()
        case .delete_ScratchableLatexType:
            deleteScratchableLatex()
        case .login_ScratchableLatexType:
            loginScratchableLatex()
        case .save_ScratchableLatexType:
            saveScratchableLatex()
        }
    }
    
    fileprivate func saveScratchableLatex() {
        if verifyNumber == 0 {
            basePoins = drawPoins
            verifyNumber = 1
        } else {
            if basePoins == drawPoins {
                print("save ok")
                let stgPoins = basePoins.description
                UserDefaults.standard.set(stgPoins, forKey: key_ScratchableLatex)
            } else {
                print("save error")
            }
        }
    }
    
    fileprivate func changeScratchableLatex() {
        let obj = UserDefaults.standard.object(forKey: key_ScratchableLatex) as? String
        if obj == drawPoins.description {
            print("change ok")
            type = .save_ScratchableLatexType
        } else {
            print("change error")
        }

    }
    
    fileprivate func deleteScratchableLatex() {
        let obj = UserDefaults.standard.object(forKey: key_ScratchableLatex) as? String
        if obj == drawPoins.description {
            print("delete ok")
            UserDefaults.standard.set("latex", forKey: key_ScratchableLatex)
        } else {
            print("delete error")
        }
    }
    
    fileprivate func loginScratchableLatex() {
        let obj = UserDefaults.standard.object(forKey: key_ScratchableLatex) as? String
        if obj == drawPoins.description {
            print("login ok")
        } else {
            print("login error")
        }
    }

}
