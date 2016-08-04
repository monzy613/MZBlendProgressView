//
//  MZBlendProgressView.swift
//  Pods
//
//  Created by Monzy Zhang on 04/08/2016.
//
//

import UIKit

private let kBackgroundSelector = NSStringFromSelector(#selector(getter: UIView.backgroundColor))

public class MZBlendProgressView: UIView {

    // MARK: - lifecycle -
    public override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.height / 2
        layer.addSublayer(progressLayer)
        addSubview(backgroundProgressLabel)
        addSubview(foregroundProgressLabel)

        // kvo
        addObserver(self, forKeyPath: kBackgroundSelector, options: [.new], context: nil)

        // init color
        backgroundColor = #colorLiteral(red: 0.1991284192, green: 0.6028449535, blue: 0.9592232704, alpha: 1)
        foregroundProgressLabel.textColor = #colorLiteral(red: 0.1991284192, green: 0.6028449535, blue: 0.9592232704, alpha: 1)

        progressLayer.strokeColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1).cgColor
        backgroundProgressLabel.textColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeObserver(self, forKeyPath: kBackgroundSelector)
    }

    // MARK: - public -
    /**
     update the progress label with the text and progress

     @param text: the progress text.

     @param progress, should be 0.0 ~ 1.0.
     ```swift
     updateLabel(with: "Progress: \(progress) %", progress)
     ```
     */
    public func updateLabel(with text: String, progress: CGFloat) {
        updateProgressBar(with: progress)
        backgroundProgressLabel.text = text
        foregroundProgressLabel.text = text
    }

    /**
     update the progress label with progress

     @param progress, should be 0.0 ~ 1.0.
     ```swift
     updateProgress(with: progress)
     ```
     */
    public func updateProgress(with progress: CGFloat) {
        updateLabel(with: "\(Int(progress * 100))%", progress: progress)
    }

    /**
     the progressbar color
     */
    public var progressBarColor: UIColor! {
        willSet {
            progressLayer.strokeColor = newValue?.cgColor
            backgroundProgressLabel.textColor = newValue
        }
    }

    // MARK: - properties -
    lazy private var progressLayer: CAShapeLayer = {
        return self.progressLayerFactory()
    }()

    lazy private var backgroundProgressLabel: UILabel = {
        let label = UILabel(frame: self.bounds)
        label.textAlignment = .center
        label.text = "0%"
        label.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        return label
    }()

    // MARK: - private properties -
    lazy private var maskProgressLayer: CAShapeLayer = {
        return self.progressLayerFactory()
    }()

    lazy private var foregroundProgressLabel: UILabel = {
        let label = UILabel(frame: self.bounds)
        label.textAlignment = .center
        label.text = "0%"
        label.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        label.layer.mask = self.maskProgressLayer
        return label
    }()

    // MARK: - kvo -
    public override func observeValue(forKeyPath keyPath: String?, of object: AnyObject?, change: [NSKeyValueChangeKey : AnyObject]?, context: UnsafeMutablePointer<Void>?) {
        if let keyPath = keyPath, let obj = object as? NSObject {
            if keyPath == kBackgroundSelector && obj == self {
                foregroundProgressLabel.textColor = backgroundColor
            }
        }
    }

    // MARK: - private -
    private func progressLayerFactory() -> CAShapeLayer {
        let progressLayer = CAShapeLayer()
        progressLayer.strokeColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1).cgColor
        progressLayer.lineCap   = kCALineCapRound
        progressLayer.lineWidth = self.frame.height * 0.6
        progressLayer.strokeEnd = 0
        let padding = self.frame.height / 2
        let progressLine = UIBezierPath()
        progressLine.move(to: CGPoint(x: padding, y: self.frame.height / 2))
        progressLine.addLine(to: CGPoint(x: self.frame.width - padding, y: self.frame.height / 2))
        progressLayer.path = progressLine.cgPath
        return progressLayer
    }

    private func updateProgressBar(with progress: CGFloat) {
        if (0.0...1.0).contains(Double(progress)) {
            maskProgressLayer.strokeEnd = progress
            progressLayer.strokeEnd = progress
        }
    }
}
