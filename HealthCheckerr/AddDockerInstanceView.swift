import SwiftUI

struct AddDockerInstanceView: View {
    @ObservedObject var viewModel: DockerInstancesViewModel
    @Environment(\.dismiss) var dismiss

    @State private var nickname = ""
    @State private var ipAddress = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Instance Details")) {
                    TextField("Nickname (e.g., Home Server)", text: $nickname)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                    TextField("IP Address (e.g., 192.168.1.55)", text: $ipAddress)
                        .keyboardType(.numbersAndPunctuation)
                }
            }
            .navigationTitle("Add Instance")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if !nickname.isEmpty && !ipAddress.isEmpty {
                            viewModel.addInstance(nickname: nickname, ipAddress: ipAddress)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}
