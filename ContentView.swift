import SwiftUI


struct RoundedRectangleButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label.foregroundColor(.black)
      Spacer()
    }
    .padding()
    .background(Color.yellow.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct OSC_DB: View {
    @State var data: [OSCData] = []
    
    var body: some View {
        NavigationView {
            List(data) {data in
                NavigationLink(destination: AppData(data: data)) {
                    HStack {
                        Image("\(data.category)")
                        Text(data.display_name)
                            .font(.headline)
                        
                        Text(data.coder)
                            .font(.subheadline)
                    }
                    .navigationTitle(Text("Open Shop Channel Downloader"))
                }
            }
            .onAppear() {
                    if Reachability.isConnectedToNetwork(){
                        OSCAPI().getData { (data) in
                            self.data = data
                        }
                    }else{
                        OSCAPI().offlineData { (data) in
                            self.data = data
                        }
                    }
                }
            }
            .frame(minWidth: 1000, minHeight: 510)
        }
    }

struct AppData: View {
    @State var IP_Address: String = ""
    let data: OSCData
    
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

                switch result {
                case .OK:
                    guard let saveURL = panel.url else {return}
                    OSCAPI().getZip(filepath: saveURL, url:data.zip_url)
                default:
                    return
                }
            }
                .padding(.top, -190)
                .padding(.leading, 500)
                .padding(.trailing, 20)
                .offset(x: 10, y: -10)
                .buttonStyle(RoundedRectangleButtonStyle())
            #elseif os(iOS)
            Button("Download") {
                    OSCAPI().getZipiOS(url:data.zip_url, app_name:data.internal_name)
            }
            #endif
            Divider()
                .padding(.top, -150)
            HStack {
                let fileSize = data.zip_size / 10000
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
            }
            HStack {
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
        }
    }
}


struct menu_Previews: PreviewProvider {
    static var previews: some View {
        OSC_DB()
    }
}

