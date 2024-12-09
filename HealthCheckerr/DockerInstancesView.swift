import SwiftUI

struct DockerInstancesView: View {
    @StateObject private var viewModel = DockerInstancesViewModel()
    @State private var showAddInstanceSheet = false
    @State private var showInfoScreen = false
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                if viewModel.dockerInstances.isEmpty {
                    Text("No Docker Instances")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                        .multilineTextAlignment(.center)
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.dockerInstances, id: \.id) { instance in
                            NavigationLink(value: instance) {
                                HStack {
                                    Image(systemName: "server.rack")
                                        .foregroundColor(.blue)
                                        .imageScale(.large)
                                    VStack(alignment: .leading) {
                                        Text(instance.nickname ?? "Unnamed")
                                            .font(.headline)
                                        Text(instance.ipAddress ?? "No IP")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        if let status = viewModel.instanceStatuses[instance.id ?? UUID()] {
                                            Text("\(status.running)/\(status.running + status.exited) Running")
                                                .font(.subheadline)
                                                .foregroundColor(.green)
                                            if status.exited > 0 {
                                                Text("\(status.exited) Exited")
                                                    .font(.subheadline)
                                                    .foregroundColor(.red)
                                            }
                                            
                                        }
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let instance = viewModel.dockerInstances[index]
                                viewModel.removeInstance(instance)
                            }
                        }
                    }
                }
            }
            .onAppear {
                Task {
                    await viewModel.fetchStatuses()
                }
            }
            .navigationTitle("HealthCheckerr")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { showInfoScreen.toggle() }) {
                        Image(systemName: "info.circle")
                            .imageScale(.large)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddInstanceSheet.toggle() }) {
                        Image(systemName: "plus")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showAddInstanceSheet) {
                AddDockerInstanceView(viewModel: viewModel)
            }
            .navigationDestination(for: DockerInstance.self) { instance in
                ContentView(ipAddress: instance.ipAddress ?? "")
            }
            .navigationDestination(isPresented: $showInfoScreen) {
                InfoScreen()
            }
        }
        .font(Font.system(size: 20))
        .italic()
    }
}
