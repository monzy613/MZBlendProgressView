//
//  ViewController.swift
//  MZBlendProgressView
//
//  Created by monzy613 on 08/04/2016.
//  Copyright (c) 2016 monzy613. All rights reserved.
//

import UIKit
import MZBlendProgressView

class ViewController: UIViewController {

    lazy var blendProgressView: MZBlendProgressView = {
        let progressView = MZBlendProgressView(frame: CGRect(x: 0, y: 0, width: 200.0, height: 30.0))
        progressView.center = self.view.center
        progressView.backgroundColor = .red
        progressView.progressLayer.strokeColor = UIColor.black.cgColor
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blendProgressView)
    }

    @IBAction func sliderSlided(_ sender: UISlider) {
        blendProgressView.updateProgress(CGFloat(sender.value))
    }
}

