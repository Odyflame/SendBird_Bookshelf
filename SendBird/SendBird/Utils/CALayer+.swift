//
//  CALayer+.swift
//  SendBird
//
//  Created by apple on 2021/03/24.
//

import UIKit

public struct Shadow {
    let color: UIColor
    let x: CGFloat
    let y: CGFloat
    let blur: CGFloat
}

public extension CALayer {
    func shadow(_ shadow: Shadow) {
        shadowColor = shadow.color.cgColor
        shadowOpacity = 1
        shadowOffset = CGSize(width: shadow.x, height: shadow.y)
        shadowRadius = shadow.blur * 0.5
        shadowPath = nil
    }
    
    func shadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
