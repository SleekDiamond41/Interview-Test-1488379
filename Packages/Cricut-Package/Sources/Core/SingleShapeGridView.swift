import SwiftUI


struct SingleShapeGridView: View {
  @ObservedObject var viewModel: SingleShapeGridViewModel

  var body: some View {
    VStack {
      ScrollView {
        ShapesGrid(viewData: viewModel.shapesGridViewData)
      }

      ButtonBarView(viewData: viewModel.buttonBarViewData)
    }
  }
}
