//
//  AppData.swift
//  Open Shop Channel Downloader
//
//  Created by Noah Pistilli on 2021-06-20.
//

import SwiftUI

struct AppData: View {
    var data: OSCData
    @State var showAlert = true
    @State var dataTask: URLSessionDownloadTask?
    @State var observation: NSKeyValueObservation?
    @State var progress: Double = 0
    let total: Double = 1

    var body: some View {
        VStack(alignment: .leading) {
            Text(data.display_name)
                .font(.title)
                .padding(.top, -170)
                .padding(.leading, 5)
            Text(data.short_description)
                .font(.title3)
                .padding(.top, -160)
                .padding(.leading, 5)
            #if os(macOS)
            Button("Download") {
                let panel = NSSavePanel()
                panel.title = "Choose where to save"
                panel.nameFieldStringValue = data.internal_name
                panel.allowedFileTypes = ["zip"]
                panel.canCreateDirectories = false
                
                let result = panel.runModal()
                if result == .OK {
                    panel.close()
                    let saveURL = panel.url
                    getZip(filepath: saveURL!, url: data.zip_url)
                }
            }
                .padding(.top, -190)
                .padding(.leading, 500)
                .padding(.trailing, 20)
                .offset(x: 10, y: -10)
                .buttonStyle(RoundedRectangleButtonStyle())
            #elseif os(iOS)
            Button("Download") {
                // I pass a fake file URL as it will be overwritten in the function
                getZip(filepath: URL(string: "moment")!, url: data.zip_url)
            }
            #endif
            Divider()
                .padding(.top, -150)
            HStack {
                let fileSize = data.zip_size / 1000
                Text("Developer: \(data.coder)")
                    .padding(.leading, 5)
                    .padding(.top, -140)
                Text("Category: \(data.category)")
                    .padding(.leading, 20)
                    .padding(.top, -140)
                Text("Size: \(fileSize) KB")
                    .padding(.leading, 20)
                    .padding(.top, -140)
            }
            Divider()
                .padding(.top, -130)
            // Having the controllers display on a screen as small as an iPhone completely destroys the UI
            // As such, we will only display for macOS
            #if os(macOS)
            HStack {
                Text("Controllers:")
                    .font(.title3)
                    .padding(.leading, 5)
                    .padding(.top, -125)
                
                // Displays compatible controllers
                switch data.controllers {
                    case "w":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                    case "ww":
                        Image("wiimote2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                    case "ws":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                    case "wk":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("keyboard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                    case "wg":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                    case "wgk":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("keyboard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                    case "wgs":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                    case "wcs":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                    case "wns":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                    case "wgcs":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                    case "wgcn":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                    case "wcns":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                    case "wgcns":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 75, y: -110)
                    case "wgcnsk":
                        Image("wiimote1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 75, y: -110)
                        Image("keyboard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 90, y: -110)
                case "wws":
                    Image("wiimote2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .offset(x: 15, y: -110)
                    Image("sdhc")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .offset(x: 30, y: -110)
                    case "wwgc":
                        Image("wiimote2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                    case "wwgcs":
                        Image("wiimote2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 66, y: -110)
                    case "wwgcn":
                        Image("wiimote2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                    case "wwcn":
                        Image("wiimote2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                    case "wwncs":
                        Image("wiimote2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                    case "wwgcns":
                        Image("wiimote2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 75, y: -110)
                    case "wwww":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                    case "wwwwc":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                    case "wwwwcs":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                    case "wwwwgcs":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                    case "wwwws":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                    case "wwwwgcn":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                    case "wwwwgc":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                    case "wwwwgncs":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 75, y: -110)
                    case "wwwwgcnsz":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 75, y: -110)
                        Image("zapper")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 90, y: -110)
                    case "wwwwgcnsk":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 75, y: -110)
                        Image("keyboard")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 90, y: -110)
                    case "wwwwgcns":
                        Image("wiimote4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 15, y: -110)
                        Image("nunchuck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 30, y: -110)
                        Image("classic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 45, y: -110)
                        Image("gc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 60, y: -110)
                        Image("sdhc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .offset(x: 75, y: -110)
                    default:
                        Text("Unknown Controller")
                }
            }
            #endif
            HStack {
                Text("Description:")
                    .padding(.leading, 5)
                    .padding(.top, -90)
                    .font(.title3)
            }
            HStack {
                Text(data.long_description)
                    .padding(.leading, 5)
                    .padding(.top, -80)
            }
            HStack {
                if progress != 0 {
                    ProgressView("Downloading", value: progress, total: total)
                        .progressViewStyle(LinearProgressViewStyle())
                        .offset(x: 0, y: 100)
                }
                if progress == 1 {
                    Text("")
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Download Complete!"), message: Text("The ZIP has been downloaded to your specified directory."), dismissButton: .default(Text("Ok")))
                        }
                }
            }
        }
    }
    // Download ZIP from OSC servers
    func getZip(filepath: URL, url: String) {
        #if os(iOS)
        var filepath = FileManager.default.urls(for: .documentDirectory,
                                                        in: .userDomainMask)[0]
        filepath = filepath.appendingPathComponent("\(data.internal_name).zip")
        #endif
        let zipURL = URL(string: url)
        dataTask = URLSession.shared.downloadTask(with: zipURL!) { (tempFileUrl, response, error) in
            observation?.invalidate()
            guard let zipTempFileUrl = tempFileUrl else {return}
            do {
                // Write to file
                let zipData = try Data(contentsOf: zipTempFileUrl)
                try zipData.write(to: filepath)
            } catch {
                print("error")
            }
        }
        observation = dataTask?.progress.observe(\.fractionCompleted) { (observationProgress, _) in
            DispatchQueue.main.async {
                progress = observationProgress.fractionCompleted
            }
        }
        dataTask?.resume()
    }
}


