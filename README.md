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

Test assertions and preconditions using XCTest.


## Overview

This package allows developers to test assertions and preconditions in tests using XCTest.
This is done by overloading Swifts runtime assertions with functions provided by `XCTRuntimeAssertions`.
These are always called in your System under Test.
Only if requested within a unit test, their implementations are swapped to assert a runtime assertion.

### Configure your System under Test

To configure your System under Test, you just need to import the `XCTRuntimeAssertion` package and call your runtime assertions
functions as usual.

```swift
import XCTRuntimeAssertions

func foo() {
    precondition(someFooCondition, "Foo condition is unmet.")
    // ...
}
```

### Testing Runtime Assertions

In your unit tests you can use the `XCTRuntimeAssertion` and
`XCTRuntimePrecondition` functions to test a block of code for which you expect
a runtime assertion to occur.

Below is a short code example demonstrating this for assertions:

```swift
try XCTRuntimeAssertion {
    assertionFailure()
}
```

Below is a short code example demonstrating this for preconditions:

```swift
try XCTRuntimePrecondition {
    preconditionFailure()
}
```

> [!TIP]
> XCTRuntimeAssertion and XCTRuntimePrecondition also support the execution of async code.

## Contributing

Contributions to this project are welcome. Please make sure to read the [contribution guidelines](https://github.com/StanfordBDHG/.github/blob/main/CONTRIBUTING.md) and the [contributor covenant code of conduct](https://github.com/StanfordBDHG/.github/blob/main/CODE_OF_CONDUCT.md) first.


## License

This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordBDHG/XCTRuntimeAssertions/tree/main/LICENSES) for more information.

![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-light.png#gh-light-mode-only)
![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-dark.png#gh-dark-mode-only)
