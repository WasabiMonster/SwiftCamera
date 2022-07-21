//
//  CameraView.swift
//  SwiftCamera
//
//  Created by Patrick Wilson on 7/21/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var model = CameraViewModel()
    
    @State var currentZoomFactor: CGFloat = 1.0
    
    var captureButton: some View {
        Button(action: {
            model.capturePhoto()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 34)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 2))
                    .frame(maxWidth: 242)
                    .frame(height: 54)
                HStack {
                    Image("camera-shutter-button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                    Text("8155")
                    Text("Oak Ave.")
                }
                .customFont(AppFonts.primaryHeadline, category: .large)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 6)
                .foregroundColor(Color.white)
            }
        })
    }
    
    var capturedPhotoThumbnail: some View {
        Group {
            if model.photo != nil {
                Image(uiImage: model.photo.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .animation(.spring())
                
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(.black)
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ZStack {
                Button(action: {
                    model.switchFlash()
                }, label: {
                    Image(systemName: model.isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                        .font(.system(size: 20, weight: .medium, design: .default))
                })
                .accentColor(model.isFlashOn ? .yellow : .white)
                
                CameraPreview(session: model.session)
                    .onAppear {
                        model.configure()
                    }
                    .alert(isPresented: $model.showAlertError, content: {
                        Alert(title: Text(model.alertError.title), message: Text(model.alertError.message), dismissButton: .default(Text(model.alertError.primaryButtonTitle), action: {
                            model.alertError.primaryAction?()
                        }))
                    })
                    .overlay(
                        Group {
                            if model.willCapturePhoto {
                                Color.green
                            }
                        }
                    )
                    .animation(.easeInOut)
                    .background(Color.gray)
                    .frameSize(color: Color.green)

                capturedPhotoThumbnail
                    .frameSize()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    captureButton
                        .frame(maxHeight: 62, alignment: .bottom)
                }
                .padding(.horizontal, 20)
                .frameSize()
                .frame(maxHeight: 62, alignment: .bottom)
            }
            .ignoresSafeArea()
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
