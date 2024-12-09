import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "DockerDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data loading failed: \(error)")
            }
        }
    }

    func fetchDockerInstances() -> [DockerInstance] {
        let request: NSFetchRequest<DockerInstance> = DockerInstance.fetchRequest()
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Fetch error: \(error)")
            return []
        }
    }

    func saveDockerInstance(nickname: String, ipAddress: String) {
        let instance = DockerInstance(context: container.viewContext)
        instance.id = UUID()
        instance.nickname = nickname
        instance.ipAddress = ipAddress
        saveContext()
    }

    func deleteDockerInstance(_ instance: DockerInstance) {
        container.viewContext.delete(instance)
        saveContext()
    }

    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("Save error: \(error)")
            }
        }
    }
}
