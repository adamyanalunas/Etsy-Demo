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
* Listing view
  * Listing images carousel
  * Description
* Purposeful mix of storyboard and programmatic view generation
* App configured for localization (although only English entered)
* Storyboard items configured with accessibility hints

### Notes

* Built for iOS 8
