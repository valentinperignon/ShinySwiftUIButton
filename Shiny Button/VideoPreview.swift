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
    private var previewLayer: AVCaptureVideoPreviewLayer?

    override func viewDidLoad() {
        checkPermission()
        guard permissionGranted else { return }

        setupCaptureSession()
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.captureSession.startRunning()
        }
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        previewLayer?.frame = view.bounds
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
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            self?.permissionGranted = granted
        }
    }

    private func setupCaptureSession() {
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
              let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice),
              captureSession.canAddInput(videoDeviceInput) else {
            return
        }

        captureSession.addInput(videoDeviceInput)

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.frame = view.bounds
        previewLayer?.videoGravity = .resizeAspectFill

        setPreviewOrientation()

        view.layer.addSublayer(previewLayer!)
    }

    private func setPreviewOrientation() {
        switch UIDevice.current.orientation {
        case .portrait:
            previewLayer?.connection?.videoOrientation = .portrait
        case .portraitUpsideDown:
            previewLayer?.connection?.videoOrientation = .portraitUpsideDown
        case .landscapeLeft:
            previewLayer?.connection?.videoOrientation = .landscapeRight
        case .landscapeRight:
            previewLayer?.connection?.videoOrientation = .landscapeLeft
        default:
            break
        }
    }
}

struct VideoPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return VideoPreviewViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) { /* Not implemented */ }
}
