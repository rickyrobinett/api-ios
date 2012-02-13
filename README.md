# libOrdrin

## Installation

The library is currently tested only in the mode where it's part of the workspace. So in case of other use than just in the default demo app it's necessary to add the library into the workspace.

* Clone repository
* Submodules

```
cd ./Ordrin
git submodule init
git submodule update
```

* Run DemoApp ;-)

## Usage

The main API documentation is to be found on the page for developers http://ordr.in/developers/api/order. In the attached DemoApp you can find basic usage of all the available methods. API is implemented supporting blocks and is very simple. See:


``` objective-c
// List of restaurants
OIAddress *address = [OIAddress addressWithStreet:@"1 Main St"
                                             city:@"College Station"
                                       postalCode:[NSNumber numberWithInt:77840]];

// You can use [OIDateTime dateTime:[NSDate date] or [OIDateTime dateTimeASAP]

[OIRestaurant restaurantsNearAddress:address availableAt:[OIDateTime dateTime:[NSDate date]] usingBlock:^void(NSArray *restaurants) {
  // array of restaurants
}];
```
