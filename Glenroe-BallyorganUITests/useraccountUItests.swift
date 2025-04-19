
import XCTest
@testable import Glenroe_Ballyorgan

final class ContentLibraryViewControllerTests: XCTestCase {

    var viewController: ContentLibraryViewController!

    override func setUpWithError() throws {
        super.setUp()
        
        // Initialize the view controller
        viewController = ContentLibraryViewController()

        // Load the view hierarchy
        viewController.loadViewIfNeeded()

        // Programmatically create the required views
        viewController.tableView = UITableView()
        viewController.searchBar = UISearchBar()
        viewController.collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        // Set up sample sections and items for testing
        let contentItems = [
            ContentItem(id: "1", title: "Item 1", description: "Description 1", imageURL: "image1.png", category: "History"),
            ContentItem(id: "2", title: "Item 2", description: "Description 2", imageURL: "image2.png", category: "Churches"),
            ContentItem(id: "3", title: "Item 3", description: "Description 3", imageURL: "image3.png", category: "Graveyards")
        ]

        viewController.sections = [
            Section(title: "History", items: contentItems.filter { $0.category == "History" }, isExpanded: false),
            Section(title: "Churches", items: contentItems.filter { $0.category == "Churches" }, isExpanded: false),
            Section(title: "Graveyards", items: contentItems.filter { $0.category == "Graveyards" }, isExpanded: false)
        ]

        viewController.filteredSections = viewController.sections
        viewController.tableView.reloadData()
    }

    override func tearDownWithError() throws {
        viewController = nil
        super.tearDown()
    }


    // Test for correct population of table view rows when a section is expanded
    func testTableViewDataPopulationOnSectionExpand() {
        // Simulate expanding the first section
        viewController.filteredSections[0].isExpanded = true
        viewController.tableView.reloadData()

        // Check the number of rows in the first section
        let numberOfRows = viewController.tableView(viewController.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 1, "The 'History' section should have 1 row when expanded.")
    }


}
