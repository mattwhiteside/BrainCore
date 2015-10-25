// Copyright © 2015 Venture Media Labs. All rights reserved.
//
// This file is part of BrainCore. The full BrainCore copyright notice,
// including terms governing use, modification, and redistribution, is
// contained in the file LICENSE at the root of the source code distribution
// tree.

import Foundation
import Upsurge

public class ReLULayer : ForwardLayer, BackwardLayer {
    public var negativeSlope = 0.0
    public let outputSize: Int

    public init(size: Int) {
        self.outputSize = size
    }

    public func forward(input: Blob, inout output: Blob) {
        assert(input.count == outputSize)
        assert(output.count == outputSize)
        for i in 0..<input.count {
            output[i] = max(input[i], 0.0) + negativeSlope * min(input[i], 0.0)
        }
    }

    public func backward(outputDiff: RealMatrix, input: RealMatrix, inout inputDiff: RealMatrix) {
        let N = inputDiff.elements.count
        for i in 0..<N {
            let factor = input.elements[i] > 0 ? 1.0 : negativeSlope
            inputDiff.elements[i] = outputDiff.elements[i] * factor
        }
    }
}