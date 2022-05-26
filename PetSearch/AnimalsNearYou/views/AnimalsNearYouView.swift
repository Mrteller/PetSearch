import SwiftUI

struct AnimalsNearYouView: View {
  @State var animals: [Animal] = Animal.mock
  @State var isLoading = true
  
  private let requestManager = RequestManager()
  
  var body: some View {
    print(animals.count)
    return NavigationView {
      List{
        ForEach(animals) { animal in
          AnimalRow(animal: animal)
        }
      }
      .task {
        // await fetchAnimals()
      }
      .listStyle(.plain)
      .navigationTitle("Animals near you")
      .overlay {
        if isLoading {
          ProgressView("Finding Animals near you...")
        }
      }
    }.navigationViewStyle(.stack)
  }
  
  @MainActor func stopLoading() async {
    isLoading = false
  }
  
  func fetchAnimals() async {
    do {
      let animalContainer: AnimalContainer = try await requestManager.perform(AnimalsRequest.getAnimalsWith(page: 1, lattitude: nil, longitude: nil))
      self.animals = animalContainer.animals
      await stopLoading()
    }
    catch {}
  }
  
}

struct AnimalsNearYouView_Previews: PreviewProvider {
  static var previews: some View {
    return AnimalsNearYouView(animals: Animal.mock, isLoading: false)
  }
}
