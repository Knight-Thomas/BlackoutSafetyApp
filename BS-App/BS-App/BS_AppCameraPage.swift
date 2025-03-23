//
//  BS_AppCameraPage.swift
//  BS-App
//
//  Created by Tom Knight on 22/03/2025.
//

import SwiftUI
import AVFoundation

struct BS_AppCameraPage: View {
    @StateObject private var cameraModel = CameraViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                CameraPreview(cameraModel: cameraModel)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        cameraModel.capturePhoto()
                    }) {
                        Circle()
                            .stroke(Color(red: 189/255, green: 80/255, blue: 255/255), lineWidth: 4)
                            .frame(width: 70, height: 70)
                    }
                    
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 54/255, green: 54/255, blue: 54/255))
                            .frame(height: 100)
                            .offset(y: 34)
                        
                        Rectangle()
                            .fill(Color(red: 189/255, green: 80/255, blue: 255/255))
                            .frame(height: 2)
                            .offset(y: -15)
                        
                        HStack{
                            CameraRollButton(imageName: "CameraRollIcon") {}                        }
                        

                        HStack(spacing: 4) {
                            CameraPageBottomButton(imageName: "MainPageIconDeactivated") {}
                            Divider()
                            CameraPageBottomButton(imageName: "MapPageIconDeactivated") {}
                            Divider().frame(width: 15)
                            CameraPageBottomButton(imageName: "CameraPageIconActivated") {}
                            Divider().frame(width: 15)
                            CameraPageBottomButton(imageName: "MessagingPageIconDeactivated") {}
                            Divider()
                            CameraPageBottomButton(imageName: "SettingsPageIconDeactivated") {}
                                               }
                        .frame(height: 50)
                        .offset(y: 25)
                    }
                }
            }
            .onAppear {
                cameraModel.checkPermissions()
            }
        }
    }
}

struct CameraPageBottomButton: View {
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 75)
                .padding(.horizontal, 4)
        }
    }
}

struct CameraRollButton: View {
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height:60)
                .offset(x:150, y:-90)
                                
        }
    }
}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var cameraModel: CameraViewModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        cameraModel.previewLayer.frame = view.bounds
        view.layer.addSublayer(cameraModel.previewLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        cameraModel.previewLayer.frame = uiView.bounds
    }
}

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    private let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private let sessionQueue = DispatchQueue(label: "cameraQueue")
    
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    override init() {
        super.init()
        previewLayer.videoGravity = .resizeAspectFill
        setupCamera()
    }
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            startSession()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.startSession()
                    }
                }
            }
        default:
            break
        }
    }
    
    private func setupCamera() {
        session.sessionPreset = .photo
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            session.beginConfiguration()
            if session.canAddInput(input) {
                session.addInput(input)
            }
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            session.commitConfiguration()
            previewLayer.session = session
        } catch {
            print("Error setting up camera: \(error)")
        }
    }
    
    private func startSession() {
        sessionQueue.async {
            if !self.session.isRunning {
                self.session.startRunning()
            }
        }
    }
    
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = .auto
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error)")
            return
        }
        print("Photo captured successfully")
    }
}

struct BS_AppCameraPage_Previews: PreviewProvider {
    static var previews: some View {
        BS_AppCameraPage()
    }
}
