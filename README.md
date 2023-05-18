<!--

This source file is part of the Stanford XCTRuntimeAssertions open-source project.

SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT
  
-->

# XCTRuntimeAssertions

[![Build and Test](https://github.com/StanfordBDHG/XCTRuntimeAssertions/actions/workflows/build-and-test.yml/badge.svg)](https://github.com/StanfordBDHG/XCTRuntimeAssertions/actions/workflows/build-and-test.yml)
[![codecov](https://codecov.io/gh/StanfordBDHG/XCTRuntimeAssertions/branch/main/graph/badge.svg?token=PcUyqu5BOx)](https://codecov.io/gh/StanfordBDHG/XCTRuntimeAssertions)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7800545.svg)](https://doi.org/10.5281/zenodo.7800545)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FXCTRuntimeAssertions%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/StanfordBDHG/XCTRuntimeAssertions)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FStanfordBDHG%2FXCTRuntimeAssertions%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/StanfordBDHG/XCTRuntimeAssertions)

XCTRuntimeAssertions allows developers to test assertions and preconditions in tests using XCTest.


## How To Use XCTRuntimeAssertions

You can use XCTestExtensions in your tests. The [API documentation](https://swiftpackageindex.com/StanfordBDHG/XCTRuntimeAssertions/documentation) provides a detailed overview of the public interface of XCTestExtensions.

1. Import `XCTRuntimeAssertions` to your system under test and call the `assert` and `precondition` functions that are defined in the `XCTRuntimeAssertions` Swift package. They provide the same functionality and parameters as the `assert` and `precondition` functions in the Swift Standard Library.

2. Use the `XCTRuntimeAssertion` and `XCTRuntimePrecondition` global functions to write unit tests that expect an `assert` and `precondition` and use the additional parameters to further refine and specify your assertions:

`XCTRuntimeAssertion` for catching assertions:
```swift
try XCTRuntimeAssertion {
 assertionFailure()
}
```

`XCTRuntimePrecondition` for catching preconditions:
```swift
try XCTRuntimePrecondition {
 preconditionFailure()
}
```

For more information, please refer to the [API documentation](https://swiftpackageindex.com/StanfordBDHG/XCTRuntimeAssertions/documentation).


## Contributing

Contributions to this project are welcome. Please make sure to read the [contribution guidelines](https://github.com/StanfordBDHG/.github/blob/main/CONTRIBUTING.md) and the [contributor covenant code of conduct](https://github.com/StanfordBDHG/.github/blob/main/CODE_OF_CONDUCT.md) first.


## License

This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordBDHG/XCTRuntimeAssertions/tree/main/LICENSES) for more information.

![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-light.png#gh-light-mode-only)
![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-dark.png#gh-dark-mode-only)
