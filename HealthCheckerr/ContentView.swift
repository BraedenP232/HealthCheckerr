import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DockerViewModel()
    let ipAddress: String

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Fetching containers...")
                    .progressViewStyle(CircularProgressViewStyle())
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List(viewModel.containers) { container in
                    NavigationLink(destination: DockerContainerDetailView(container: container)) {
                        HStack {
                            Image(systemName: container.state == "running" ? "play.circle.fill" : "stop.circle.fill")
                                .foregroundColor(container.state == "running" ? .green : .red)
                                .imageScale(.large)
                            VStack(alignment: .leading) {
                                Text(container.formattedName)
                                    .font(.headline)
                                Text(container.status)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(container.state.capitalized)
                                .font(.callout)
                                .foregroundColor(container.state == "running" ? .green : .red)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
        }
        .navigationTitle("Containers")
        .onAppear {
            NetworkManager.shared.setDockerHost(ipAddress: ipAddress)
            viewModel.fetchContainers()
        }
    }
}
