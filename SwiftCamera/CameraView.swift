//
//  CameraView.swift
//  SwiftCamera
//
//  Created by Patrick Wilson on 7/21/22.
//

import SwiftUI

struct CameraView: View {
    @StateObject var viewModel = CameraViewModel()
    
    @State var currentZoomFactor: CGFloat = 1.0
    
    var captureButtons: some View {
        Button(action: {
            viewModel.capturePhoto()
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
            if viewModel.photo != nil {
                Image(uiImage: viewModel.photo.image!)
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
        ZStack(alignment: .topLeading) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            CameraPreview(session: viewModel.session)
                .onAppear { viewModel.configure() }
                .alert(isPresented: $viewModel.showAlertError, content: {
                    Alert(title: Text(viewModel.alertError.title),
                          message: Text(viewModel.alertError.message),
                          dismissButton: .default(Text(viewModel.alertError.primaryButtonTitle),
                                                  action: {
                        viewModel.alertError.primaryAction?()
                    }))
                })
                .overlay(
                    Group {
                        if viewModel.willCapturePhoto { Color.white.opacity(0.75) }
                    }
                )
                .animation(.easeInOut)
                .background(Color.gray)
     
            VStack {
                LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom)
                    .frame(maxHeight: 232)
                
                Spacer()
                
                ZStack(alignment: .bottom) {
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                        .frame(maxHeight: 160, alignment: .bottom)

                    Image("camera-viewfinder")
                        .shadow(color: Color.black.opacity(0.4), radius: 1, x: 0, y: 0)
                        .padding(.bottom, 178)
                }
            }

            
            capturedPhotoThumbnail
                .frame(alignment: .leading)
            
            VStack(spacing: 0) {
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    captureButtons
                        .frameSize()
                }
                .padding(.bottom, 42)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
