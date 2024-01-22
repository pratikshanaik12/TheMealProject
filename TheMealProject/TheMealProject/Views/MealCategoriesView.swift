import SwiftUI

struct MealCategoriesView: View {
    @StateObject var viewModel = MealCategoriesViewModel()

    var body: some View {
            List(viewModel.categories, id: \.idCategory) { category in
                NavigationLink(destination: MealsView(category: category.strCategory)) {
                    HStack {
                        if let imageUrl = category.strCategoryThumb {
                            AsyncImageLoader(url: imageUrl)
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 3)
                                .padding(.trailing, 10)
                        }
                        Text(category.strCategory)
                    }
                }
            }
            .navigationTitle("Meal Categories")
            .onAppear {
                viewModel.fetchMealCategories()
            }

    }
}




