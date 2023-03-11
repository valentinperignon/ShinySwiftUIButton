//
//  VideoPreview.swift
//  Shiny Button
//
//  Created by Valentin Perignon on 04/03/2023.
//

import AVFoundation
import UIKit
import SwiftUI

private class VideoPreviewViewController: UIViewController {
    private var permissionGranted = false

    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "fr.valentinperignon.VideoPreview")

    private var previewLayer = AVCaptureVideoPreviewLayer()
    var screenRect: CGRect!

    override func viewDidLoad() {
        checkPermission()

        guard permissionGranted else { return }

        setupCaptureSession()
        captureSession.startRunning()
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        screenRect = UIScreen.main.bounds
        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)

        setPreviewOrientation()
    }

    private func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            permissionGranted = true
        case .notDetermined:
            requestPermission()
        default:
            permissionGranted = false
        }
    }

    private func requestPermission() {
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            guard let self else { return }
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
    }

    private func setupCaptureSession() {
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoDeviceInput) else {
            return
        }

        captureSession.addInput(videoDeviceInput)

        screenRect = UIScreen.main.bounds

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        previewLayer.videoGravity = .resizeAspectFill

        setPreviewOrientation()

        view.layer.addSublayer(previewLayer)
    }

    private func setPreviewOrientation() {
        switch UIDevice.current.orientation {
        case .portrait:
            previewLayer.connection?.videoOrientation = .portrait
        case .portraitUpsideDown:
            previewLayer.connection?.videoOrientation = .portraitUpsideDown
        case .landscapeLeft:
            previewLayer.connection?.videoOrientation = .landscapeRight
        case .landscapeRight:
            previewLayer.connection?.videoOrientation = .landscapeLeft
        default:
            break
        }
    }
}

struct VideoPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return VideoPreviewViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { }
}
