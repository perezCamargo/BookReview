//
//  ImageLoadingView.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

final class ImageLoadingView: UIView, LoadingView {
    private static let defaultRect: CGRect = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)

    private let loadingImage: UIImageView = UIImageView()
    private var isRunning = false
    private var timer: Timer? = Timer()
    private var isAdded = false

    convenience init(_ image: UIImage) {
        self.init(frame: ImageLoadingView.defaultRect)
        self.loadingImage.image = image
        self.commonInit()
    }
    
    override private init(frame: CGRect) {
        super.init(frame: ImageLoadingView.defaultRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.loadingImage.contentMode = .scaleAspectFit
        self.loadingImage.frame = ImageLoadingView.defaultRect
        self.loadingImage.widthAnchor.constraint(equalToConstant: self.loadingImage.frame.width).isActive = true
        self.loadingImage.heightAnchor.constraint(equalToConstant: self.loadingImage.frame.height).isActive = true
        self.loadingImage.tintColor = .purple
        self.addSubview(self.loadingImage)
        self.layer.cornerRadius = ImageLoadingView.defaultRect.width / 2.0
    }

    func run(_ view: UIView) {
        guard !self.isRunning else { return }
        self.isRunning = true
        self.alpha = 1.0
        let x = view.bounds.midX - (ImageLoadingView.defaultRect.width / 2.0)
        let y = view.bounds.midY - (ImageLoadingView.defaultRect.height / 2.0)
        
        self.frame = CGRect(x: x,
                            y: y,
                            width: ImageLoadingView.defaultRect.width,
                            height: ImageLoadingView.defaultRect.height)

        if !isAdded {
            view.addSubview(self)
        }
        self.timer = Timer.scheduledTimer(timeInterval: 0.03,
                                          target: self,
                                          selector: #selector(timerAction),
                                          userInfo: nil,
                                          repeats: true)

        guard self.timer != nil else { return }
        RunLoop.main.add(self.timer!, forMode: .common)
    }

    private func refreshViewFrame(_ view: UIView) {
        self.frame = CGRect(x: (view.frame.width / 2.0) - (ImageLoadingView.defaultRect.width / 2.0 ),
                            y: (view.frame.height / 2.0) - (ImageLoadingView.defaultRect.height / 2.0 ),
                            width: ImageLoadingView.defaultRect.width,
                            height: ImageLoadingView.defaultRect.height)
    }

    @objc private func timerAction() {
        RunLoop.main.perform(inModes: [.common]) {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.loadingImage.rotate(degrees: self.loadingImage.rotation.degrees + 5.0)
            }
        }
    }

    func stop() {
        self.timer?.invalidate()
        self.isRunning = false
        self.alpha = 0.0
    }
}
