# Etsy Search

A app to demo features of the Etsy API.

### Getting Started

* Clone this repo
* Run `pod install` in the repo's local folder
* Open the `.xcworkspace` file
* Build for desired device

### Features

* API calls use configuration object with default values
* Displays trending listings on startup
* Search by keyword
  * Debounced auto search
  * Canceling search goes back to trending listings
* Filter
  * Filter by price bracket (look for the rarely applicable, much despised switch statement!)
  * KVO + delegate == lulz, sure why not
* Listing view
  * Listing images carousel
  * Description
* Purposeful mix of storyboard and programmatic view generation
* App configured for localization (although only English entered)
* Storyboard items configured with accessibility hints

### Failures
* Async image loading
  * Occasional crashers around AFNetworking's async image loader that I didn't debug. Fine for a demo. Laughably serious for prod code.
* Fancy collection layouts
  * [waterfall_layout](https://github.com/adamyanalunas/Etsy-Demo/tree/waterfall_layout) was an attempt at the Etsy/Pinterest/masonry-style layout
  * [springy_collection](https://github.com/adamyanalunas/Etsy-Demo/tree/springy_collection) was an attempt at UIDynamics to jiggle the collection as you scroll up and down. Couldn't get past a bug that hid all cells except for last row after loading data from API.

### Notes

* Built for iOS 8
