import Interface
import SwiftUI


public struct HomeView: View {
  @ObservedObject var viewModel: HomeViewModel

  var isNavigationPresented: Binding<Bool> {
    Binding {
      viewModel.singleShapeGridViewModel != nil
    } set: { shouldShow in
      if !shouldShow {
        viewModel.singleShapeGridViewModel = nil
      }
    }
  }


  public init(viewModel: HomeViewModel) {
    self.viewModel = viewModel
  }

  public var body: some View {
    NavigationStack {
      VStack {
        ScrollView {
          ShapesGrid(viewData: viewModel.shapesGridViewData)
        }
        
        ButtonBarView(viewData: viewModel.buttonBarViewData)
      }
      .navigationTitle("Home")
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Clear All") {
            viewModel.clearAllTapped()
          }
        }

        ToolbarItem(placement: .primaryAction) {
          Button("Edit Circles") {
            viewModel.editCircleTapped()
          }
          .contextMenu {
            Button("Edit Squares") {
              viewModel.editSquareTapped()
            }
            Button("Edit Triangles") {
              viewModel.editTriangleTapped()
            }
          }
        }
      }
      .task {
        await viewModel.task()
      }
      .navigationDestination(isPresented: isNavigationPresented) {
        if let viewModel = viewModel.singleShapeGridViewModel {
          SingleShapeGridView(viewModel: viewModel)
        }
      }
    }
  }
}

#Preview("Circles Only") {
  NavigationStack {
    HomeView(
      viewModel: HomeViewModel(dependencies: .mock)
    )
  }
}

#Preview("All Shapes") {
  let dependencies = using(Dependencies.mock) {
    $0.getButtons = {
      [
        .mock,
        .init(name: "Pointy", shape: .triangle),
        .init(name: "Blocky", shape: .square),
      ]
    }
  }

  NavigationStack {
    HomeView(
      viewModel: HomeViewModel(dependencies: dependencies)
    )
  }
}
