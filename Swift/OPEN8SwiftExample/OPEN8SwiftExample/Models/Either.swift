//
//  Either.swift
//  OPEN8SwiftExample
//
//  Copyright (c) 2017-present, OPEN8, Inc. All rights reserved.
//

import Foundation

enum Either<L, R> {
    case Left(L)
    case Right(R)
}
