//
//  MZBlendProgressView.swift
//  Pods
//
//  Created by Monzy Zhang on 04/08/2016.
//
//

import UIKit

public class MZBlendProgressView: UIView {

    // MARK: - properties -
    lazy private var maskProgressLayer: CAShapeLayer = {
        return self.progressLayerFactory()
    }()

    lazy public var progressLayer: CAShapeLayer = {
        return self.progressLayerFactory()
    }()

    lazy public var progressLabel: UILabel = {
        let label = UILabel(frame: self.bounds)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "0%"
        label.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        return label
    }()

    lazy private var foregroundProgressLabel: UILabel = {
        let label = UILabel(frame: self.bounds)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "0%"
        label.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        label.layer.mask = self.maskProgressLayer
        return label
    }()

    // MARK: - lifecycle -
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.masksToBounds = true
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.cornerRadius = frame.height / 2
        layer.addSublayer(progressLayer)
        addSubview(progressLabel)
        addSubview(foregroundProgressLabel)

        // kvo
        progressLayer.addObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: CAShapeLayer.strokeColor)), options: [.new], context: nil)
        self.addObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: UIView.backgroundColor)), options: [.new], context: nil)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        progressLayer.removeObserver(self, forKeyPath: "strokeColor")
        self.removeObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: UIView.backgroundColor)))
    }

    // MARK: - kvo -
    public override func observeValue(forKeyPath keyPath: String?, of object: AnyObject?, change: [NSKeyValueChangeKey : AnyObject]?, context: UnsafeMutablePointer<Void>?) {
        if let keyPath = keyPath, let obj = object as? NSObject {
            if keyPath == NSStringFromSelector(#selector(getter: UIView.backgroundColor)) && obj == self {
                foregroundProgressLabel.textColor = backgroundColor
            } else if keyPath == "strokeColor" && obj == progressLayer {
                progressLabel.textColor = UIColor(cgColor: progressLayer.strokeColor ?? UIColor.white.cgColor)
            }
        }
    }

    // MARK: - public -
    public func updateProgress(_ progress: CGFloat) {
        if progress <= 1.0 {
            maskProgressLayer.strokeEnd = progress
            progressLayer.strokeEnd = progress

            progressLabel.text = "\(Int(progress * 100))%"
            foregroundProgressLabel.text = "\(Int(progress * 100))%"
        }
    }

    // MARK: - private -
    private func progressLayerFactory() -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.lineCap   = kCALineCapRound
        progressLayer.lineJoin  = kCALineJoinBevel
        progressLayer.lineWidth = self.frame.height * 0.6
        progressLayer.strokeEnd = 0
        let padding = self.frame.height / 2
        let progressLine = UIBezierPath()
        progressLine.move(to: CGPoint(x: padding, y: self.frame.height / 2))
        progressLine.addLine(to: CGPoint(x: self.frame.width - padding, y: self.frame.height / 2))
        progressLayer.path = progressLine.cgPath
        return progressLayer
    }
}
