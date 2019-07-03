# iOS
Playground of new toys

### iDailyProject
iOS application daily practice in swift.

#### Known issues:
1. cannot show photo reviews.

error log:

> 2019-04-30 21:40:22.204089-0400 EatEat[69983:2445476] [error] warning: Multiple NSEntityDescriptions claim the NSManagedObject subclass 'RestaurantPhoto' so +entity is unable to disambiguate. CoreData: warning: Multiple NSEntityDescriptions claim the NSManagedObject subclass 'RestaurantPhoto' so +entity is unable to disambiguate.

2. Done button doesn't show on custom notification setting page.


3. Warning - ambiguous constraints

> [Warning] Warning once only: Detected a case where constraints ambiguously suggest a height of zero for a tableview cell's content view. We're considering the collapse unintentional and using standard height instead.

Fixed:
```swift 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        requestContactPermission()
    }
```
why use interface builder to set cell height doesn't work???

***

#### Path

Advanced
****
[20190702] custom UICollectionViewLayout - how to implement shouldInvalideLayout() in terms of performance; fix incorrect numbers of row and columns.

[20190605] custom UICollectionViewLayout - calculate content size and set layout attributes for cells.

[20190604] custom UICollectionViewLayout - precalculation.

[20190603] standard way to conform UICollectionViewDelegateFlowLayout; custom UICollectionViewLayout - introduction. 

[20190531] replace with collection view; image round corner in awakeFromNib (a bit like init in android view).

[20190530] table view delegate: trailingSwipeActionsConfigurationForRowAt; moveRowAt.

[20190529] table view delegate: didSelectRowAt.

[20190528] table view prefetching.

[20190527] handle images within a tableview cell.

[20190524] common protocols of tableview; under-the-hood performance of tableView.

Basics
****
[20190522] custom notification settings; siri reading.

[20190517] custom notification - part one: notification extension.

[20190516] group notifications; hidden and summary text of notifications.

[20190515] embed image in notification; add notification category with actions.

[20190514] deliver notification quietly.

[20190513] checked notification permission; created basic notification.

[20190511] notification reading.

[20190510] displayed restaurant list through iMessage; sent messages of restaurant details.

[20190509] added iMessage target.

[20190503] update location list style, restaurant list and details for pad.

[20190501] add round corner effect for explore cell; hide navigation bar on explore screen; update navigation bar and tab bar appearance; adjust spacing of explore cell.

[20190430] remove unused ReviewDataManager; clean up.

[20190426] Show overall rating for restaurant, photo reviews.

[20190423] Reviews storyboard, viewcontrollers and displaying reviews.

[20190422] Added saving restaurant review and photo item.

[20190420] What is core data and how to use data from it.

[20190417] PhotoFilterViewController part two; added permission request.

[20190416] PhotoFilterViewController part one.

[20190412] added photo filter storyboard; fixed incorrect unwind segue.

[20190411] added image filter and photo item.

[20190410] added review form view controller.

[20190409] added custom rating view; handled touch event of rating view; added review storyboard.

[20190408] fixed ui constraint warnings; passed data from list to item view.

[20190406] completed restaurant details - part two.

[20190405] added missing cuisines in restaurant cell; completed restaurant details - part one.

[20190404] provided data to restaurant list.

[20190403] Added data manager for restaurant list; added no data view for restaurant list.

[20190402] passed data to location and restaurant list; added decorable items and set up restaurant cell.

[20190401] added LocationItem and passed location data to explore view.

[20190331] worked with json file.

[20190328] separated main storyboard - part two; organized controller codes using extension.

[20190327] created storyboard references; separated main storyboard - part one.

[20190324] added custom annotations.

[20190322] added annotations in map view; refactored codes of handling fetching data from plist file.

[20190321] fed data for table view in LocationViewController.

[20190320] tied data fetching from a plist to explore collection view; set up restaurant cell.

[20190319] mvc and exploreViewController code reading.

[20190318] classes vs structs; controller sample.

[20190314] worked with table view cells collection view cells and auto layout.

[20190313] added lower level pages for exploring branch; table view; review what have learned.

[20190312] extended story board: search result view controller; new color set; connection of two places using navigation controller.

[20190307] started a new demo project: import assets, organize basic storyboards and launch screen.

### OCiDailyProject
iOS application daily practice in object-c

[20190211] a simple ui to get the chosen color.

[20190130] hello world

### SfDaily
macOs project && Swift playground

[20190306] dictionary and set.
[20190305] range and collections.
[20190124] primitive data types, expression, control flow and functions.

### OcDaily
macOs project && Object-c playground

[20190123] expression
[20190122] primitive data types

### Playground
First simple game to have a rough idea of iOS app.
