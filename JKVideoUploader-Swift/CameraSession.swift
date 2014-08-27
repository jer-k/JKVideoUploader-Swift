//
//  CameraSession.swift
//  JKVideoUploader-Swift
//
//  Created by Jeremy Kreutzbender on 8/25/14.
//  Copyright (c) 2014 Jeremy Kreutzbender. All rights reserved.
//

import UIKit
import AVFoundation

class CameraSession: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    let cameraSession = AVCaptureSession()
    let cameraQueue = dispatch_queue_create("com.camerasession.videouploader", DISPATCH_QUEUE_SERIAL)
    var videoDeviceInput: AVCaptureDeviceInput!
    let videoDeviceOutput = AVCaptureVideoDataOutput()
    
    //MARK: - Initialization
    
    override init() {
        super.init()
        
        var error: NSError?
        let input = AVCaptureDeviceInput.deviceInputWithDevice(self.backCamera(), error: &error) as AVCaptureDeviceInput
        if !(error != nil) {
            //cameraSession.sessionPreset = ?
            if cameraSession.canAddInput(videoDeviceInput) {
                cameraSession.addInput(videoDeviceInput)
                
                let audioDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio)
                let audioInput = AVCaptureDeviceInput.deviceInputWithDevice(audioDevice, error: &error) as AVCaptureDeviceInput
                
                if cameraSession.canAddInput(audioInput) {
                    cameraSession.addInput(audioInput)
                }
                
                videoDeviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_420YpCbCr8BiPlanarFullRange]
                videoDeviceOutput.setSampleBufferDelegate(self, queue: cameraQueue)
                if cameraSession.canAddOutput(videoDeviceOutput) {
                    cameraSession.addOutput(videoDeviceOutput)
                }
            }
        }
        
    }
    
    //MARK: - Authorization
    func authorizeCameraUse() {
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo) { granted -> Void in
            if !granted {
                dispatch_async(dispatch_get_main_queue(), {
                    UIAlertView(
                        title: "Could not use camera!",
                        message: "This application does not have permission to use camera. Please update your privacy settings.",
                        delegate: self,
                        cancelButtonTitle: "OK").show()
                })
            }
        }
    }
    
    //MARK: - PreviewLayer methods
    
    func createPreviewLayer() {
        //stubbed for now
    }
    
    //MARK: - AVCaptureVideoDataOutputSampleBufferDelegate methods
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        CVPixelBufferLockBaseAddress(imageBuffer, 0)
        let width = CVPixelBufferGetWidthOfPlane(imageBuffer, 0)
        let height = CVPixelBufferGetHeightOfPlane(imageBuffer, 0)
        let bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0)
    }

    //MARK: - Private methods
    
    private func backCamera() -> AVCaptureDevice? {
        for device in AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo) as [AVCaptureDevice] {
            if device.position == .Back {
                return device
            }
        }
        return nil
    }
    
}
