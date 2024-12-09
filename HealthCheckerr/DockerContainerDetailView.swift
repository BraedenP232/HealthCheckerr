import SwiftUI

struct DockerContainerDetailView: View {
    let container: DockerContainer
    @ObservedObject private var viewModel = DockerViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(container.formattedName)
                .font(.largeTitle)
                .bold()

            Text("Status: \(container.status)")
                .font(.headline)

            Text("State: \(container.state.capitalized)")
                .font(.headline)
                .foregroundColor(container.state == "running" ? .green : .red)

            Spacer()

            HStack {
                Button(action: {
                    viewModel.performAction(on: container.id, action: "start")
                }) {
                    Text("Start")
                        .foregroundColor(.white)
                        .padding()
                        .background(container.state == "running" ? Color.gray : Color.green)
                        .cornerRadius(10)
                }
                .disabled(container.state == "running")

                Button(action: {
                    viewModel.performAction(on: container.id, action: "stop")
                }) {
                    Text("Stop")
                        .foregroundColor(.white)
                        .padding()
                        .background(container.state == "running" ? Color.red : Color.gray)
                        .cornerRadius(10)
                }
                .disabled(container.state != "running")

                Button(action: {
                    viewModel.performAction(on: container.id, action: "restart")
                }) {
                    Text("Restart")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .navigationTitle("Container Details")
        .onAppear {
            viewModel.fetchContainers()
        }
    }
}
