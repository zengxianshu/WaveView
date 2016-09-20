//
//  WaveView.swift
//  Onion
//
//  Created by 曾墨 on 16/7/19.
//  Copyright © 2016年 Sky Platanus Inc.,. All rights reserved.
//



import UIKit

open class WaveView: UIView {
  
  // column begin is from side
  @IBInspectable open var isAlongTheEdge: Bool = false
  
  @IBInspectable open var binWidth: CGFloat = 2.0
  
  @IBInspectable open var numOfBins: Int = 3
  
  /// center for wave
  @IBInspectable open var anchorPointY: CGFloat = 1.0
  
  /// this time effect wave speed
  @IBInspectable open var durationTime: CGFloat = 4.0
  
  @IBInspectable open var binColor: UIColor = .clear {
    didSet {
      _ = self.layer.sublayers?.map {
        $0.backgroundColor = binColor.cgColor
      }
    }
  }
  
  fileprivate func setup() {
    
    guard self.binWidth > 0 else {
      self.binWidth = self.bounds.width/CGFloat(numOfBins)
      self.layoutSubviews()
      return
    }
    
    var newBinWidth = self.binWidth
    
    self.layer.removeAllAnimations()
    self.layer.sublayers?.removeAll()
    
    let heightMax = self.bounds.height
    let widthMax = self.bounds.width
    
    let paddingNum = self.isAlongTheEdge ? numOfBins - 1 : numOfBins + 1
    
    var paddingWidth: CGFloat = 0
    
    if CGFloat(numOfBins) * newBinWidth <= widthMax {
      paddingWidth = (widthMax - CGFloat(numOfBins) * newBinWidth) / CGFloat(paddingNum)
    } else {
      paddingWidth = 0
      newBinWidth = widthMax / CGFloat(numOfBins)
    }
    
    let firstBinOriginX = self.isAlongTheEdge ? 0 : paddingWidth
    
    for index in 1...numOfBins {
      
      let frameX = ( paddingWidth + newBinWidth ) * CGFloat(index - 1) + firstBinOriginX
      
      let animLayer = self.animLayer(CGRect.init(x: frameX, y: heightMax * (anchorPointY - 0.5 ), width: newBinWidth, height: heightMax))
      
      self.layer.addSublayer(animLayer)
    }
  }
  
  fileprivate func animLayer(_ frame: CGRect) -> CALayer{
    let layer = CALayer.init()
    layer.frame = frame
    layer.anchorPoint = CGPoint.init(x: 0.5, y: anchorPointY)
    layer.bounds.size.height = self.getWaveHeight()
    layer.backgroundColor = binColor.cgColor
    layer.add(self.getAnim(), forKey: "waveAnim")
    return layer
  }
  
  fileprivate func getAnim() -> CAKeyframeAnimation{
    let heightAnim = CAKeyframeAnimation.init(keyPath: "bounds.size.height")
    heightAnim.values = self.getAnimValues()
    heightAnim.repeatCount  = MAXFLOAT
    heightAnim.duration =  TimeInterval(durationTime) + TimeInterval(arc4random_uniform(3)) * 0.1
    heightAnim.isRemovedOnCompletion = false 
    return heightAnim
  }
  
  fileprivate func getAnimValues() -> [CGFloat] {
    
    var heightValues = [CGFloat]()
    heightValues.append(self.getWaveHeight())
    
    while heightValues.count < 20 {
      let waveHeight = self.getWaveHeight()
      let priorWave = heightValues.last!
      if abs(waveHeight - priorWave) > self.bounds.height * 0.2 {
        heightValues.append(waveHeight)
      }
    }
    
    heightValues.append(heightValues.first!)
    return heightValues
  }
  
  fileprivate func getWaveHeight() -> CGFloat {
    return self.bounds.height * CGFloat( arc4random_uniform(9) + 2 ) / 10.0
  }
  
  override open func layoutSubviews() {
    super.layoutSubviews()
    self.setup()
  }
}
