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
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blendProgressView)
        blendProgressView.backgroundColor = #colorLiteral(red: 0.2202886641, green: 0.7022308707, blue: 0.9593387842, alpha: 1)
        blendProgressView.progressBarColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
    }

    @IBAction func sliderSlided(_ sender: UISlider) {
        blendProgressView.updateLabel(with: "\(Int(sender.value * 100))%", progress: CGFloat(sender.value))
    }
}

