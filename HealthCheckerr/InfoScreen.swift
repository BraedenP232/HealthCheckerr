import SwiftUI
import MarkdownUI

struct InfoScreen: View {
    @State private var showDockerInstructions = true
    @State private var showAppInstructions = true
    
    private let appInstructions =
    """
    ## Using the app
    1. Add Docker Instances:  
    Tap the "+" button in the top-right corner to add a new Docker instance by its IP address and nickname.<br>
    2. Monitor Containers:  
    Select a Docker instance from the list to view all its containers and monitor their health status.<br>
    3. Start/Stop/Restart Containers:  
    Tap on a container to view details and perform actions like starting, stopping, or restarting.<br>
    4. Switching Docker Instances:  
    Use the back button to return to the list of Docker instances and select another one.<br>
    """
    
    private let dockerInstructions =
    """
    🚨
    **Docker instances must be configured to accept API traffic over the HTTP API.**
    
    ---
    
    ## The [instructions](https://gist.github.com/styblope/dc55e0ad2a9848f2cc3307d4819d819f):
    1. Add the following to **/etc/docker/daemon.json**:  
    `{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}`  
    2. Add the following to **/etc/systemd/system/docker.service.d/override.conf**:  
    `[Service]`  
    `ExecStart=`  
    `ExecStart=/usr/bin/dockerd`  
    3. Reload the systemd daemon:  
    `sudo systemctl daemon-reload`  
    4. Restart docker:  
    `sudo systemctl restart docker.service`
    """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Markdown(
                """
                **HealthCheckerr** by [Braeden Pelletier](https://braeden-pelletier.com/)   
                An app to monitor and control *Docker* images from your iOS device.<br>
                """)
                .font(.body)
                .markdownTextStyle(\.link) {
                    ForegroundColor(.cyan)
                }
                .markdownTextStyle(\.strong) {
                    ForegroundColor(.orange)
                    FontSize(26)
                }
                
                // App Instructions Button
                Button(action: {
                    withAnimation {
                        showAppInstructions.toggle()
                    }
                }) {
                    HStack {
                        Text("App Instructions")
                            .font(.title2)
                            .bold()
                        Image(systemName: showAppInstructions ? "chevron.up" : "chevron.down")
                    }
                }
                .padding(.bottom, 5)
                
                // App Instructions (Only rendered when shown)
                if showAppInstructions {
                    VStack {
                        Markdown(appInstructions)
                            .markdownTextStyle(\.code) {
                                FontFamilyVariant(.monospaced)
                                FontSize(.em(0.85))
                                ForegroundColor(.purple)
                                BackgroundColor(.purple.opacity(0.25))
                            }
                            .markdownTextStyle(\.link) {
                                ForegroundColor(.purple)
                            }
                    }
                    .animation(.easeInOut, value: showAppInstructions) // Smooth transition
                    .padding()
                    .background(Color.gray.opacity(0.1))
                }
                
                // Docker API Instructions Button
                Button(action: {
                    withAnimation {
                        showDockerInstructions.toggle()
                    }
                }) {
                    HStack {
                        Text("Docker API Instructions")
                            .font(.title2)
                            .bold()
                        Image(systemName: showDockerInstructions ? "chevron.up" : "chevron.down")
                    }
                }
                .padding(.bottom, 5)
                
                // Docker API Instructions (Only rendered when shown)
                if showDockerInstructions {
                    VStack {
                        Markdown(dockerInstructions)
                            .markdownTextStyle(\.code) {
                                FontFamilyVariant(.monospaced)
                                FontSize(.em(0.85))
                                ForegroundColor(.purple)
                                BackgroundColor(.purple.opacity(0.25))
                            }
                            .markdownTextStyle(\.link) {
                                UnderlineStyle(.single)
                            }
                    }
                    .animation(.easeInOut, value: showDockerInstructions) // Smooth transition
                    .padding()
                    .background(Color.gray.opacity(0.1))
                }
                
                Spacer()
            }
            .padding()
            .textSelection(.enabled)
        }
        .navigationBarTitle("Info", displayMode: .inline)
    }
}
