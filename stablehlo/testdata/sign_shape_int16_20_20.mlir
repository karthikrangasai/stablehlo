// RUN: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xi16>
    %1 = call @expected() : () -> tensor<20x20xi16>
    %2 = stablehlo.sign %0 : tensor<20x20xi16>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xi16>, tensor<20x20xi16>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xi16> {
    %0 = stablehlo.constant dense<"0x0000FDFF06000200020000000000030004000000FEFF0100FFFF0100FFFF0100FCFF0400FEFF00000100FFFF040002000000F9FF00000000FCFF01000000FFFF0100FCFFFDFF000007000000FFFFFFFFFDFF0000000000000300FBFFFFFF040001000300FEFF00000300FFFF0000FDFFFEFFFEFFFBFF0200030000000100FEFF0000000001000200000000000300020001000100FEFF00000000030003000100FEFF0200FFFF0000F8FFFCFF0100000000000500FFFF0100FCFF0100FEFFFDFF0000020005000000FEFF0400FFFF00000000FFFF0100FCFF0000FCFF040000000700FEFFFEFFFFFFFEFFFDFF000001000100FFFFFFFF00000200FEFFFFFF0300FAFF030000000300FBFFFCFFFEFFF9FF0100FFFFFFFF04000000FFFFFEFF01000500FFFFFEFF00000000000000000000F8FF0200FEFFF8FF00000100FFFF01000000F9FF010002000100F9FF0000FEFF010001000200FAFF02000200000002000000FCFF0300010002000000FDFF0100FFFFFEFF0500FFFF0200FDFF000000000200FFFFFEFF0300F9FFFFFFFEFF01000300FCFF0000010000000000040000000400000002000000000000000000FFFF02000000030000000200FCFFFFFFFFFFFFFF0000000000000200FFFFFFFF0000000000000500FAFFFEFFFEFFFEFFFFFF0000FFFF00000700FCFF0100000000000000FFFF00000100FFFFFEFFFFFF0400FFFF0000FCFF0100000003000000FFFF02000200FFFF07000300000002000700FFFFFFFFFCFF0000FFFF0000FEFFFEFF02000100FDFF0100FFFFFFFFFFFF010002000400FAFFFEFF03000100FCFFFDFF02000100FAFF0100FFFF0000FEFFFFFF000000000400FDFF02000100FEFF030000000000FEFF0000010004000000F5FF0000FDFF04000200FFFF00000200FFFF000000000000FAFFFDFFFEFF0400FDFF00000000FBFF05000000FBFF0100FEFF00000100FDFFFFFFFFFF02000200FEFF0200FCFF040000000500FFFFFEFF0400FBFF0000FFFF00000300000000000100FFFFFCFF000000000100FCFF0000FBFF00000300FFFF0600FEFF02000300FBFF0500000001000000FEFF000000000300FFFF000004000600FDFFFFFFFFFF0000"> : tensor<20x20xi16>
    return %0 : tensor<20x20xi16>
  }
  func.func private @expected() -> tensor<20x20xi16> {
    %0 = stablehlo.constant dense<"0x0000FFFF01000100010000000000010001000000FFFF0100FFFF0100FFFF0100FFFF0100FFFF00000100FFFF010001000000FFFF00000000FFFF01000000FFFF0100FFFFFFFF000001000000FFFFFFFFFFFF0000000000000100FFFFFFFF010001000100FFFF00000100FFFF0000FFFFFFFFFFFFFFFF0100010000000100FFFF0000000001000100000000000100010001000100FFFF00000000010001000100FFFF0100FFFF0000FFFFFFFF0100000000000100FFFF0100FFFF0100FFFFFFFF0000010001000000FFFF0100FFFF00000000FFFF0100FFFF0000FFFF010000000100FFFFFFFFFFFFFFFFFFFF000001000100FFFFFFFF00000100FFFFFFFF0100FFFF010000000100FFFFFFFFFFFFFFFF0100FFFFFFFF01000000FFFFFFFF01000100FFFFFFFF00000000000000000000FFFF0100FFFFFFFF00000100FFFF01000000FFFF010001000100FFFF0000FFFF010001000100FFFF01000100000001000000FFFF0100010001000000FFFF0100FFFFFFFF0100FFFF0100FFFF000000000100FFFFFFFF0100FFFFFFFFFFFF01000100FFFF0000010000000000010000000100000001000000000000000000FFFF01000000010000000100FFFFFFFFFFFFFFFF0000000000000100FFFFFFFF0000000000000100FFFFFFFFFFFFFFFFFFFF0000FFFF00000100FFFF0100000000000000FFFF00000100FFFFFFFFFFFF0100FFFF0000FFFF0100000001000000FFFF01000100FFFF01000100000001000100FFFFFFFFFFFF0000FFFF0000FFFFFFFF01000100FFFF0100FFFFFFFFFFFF010001000100FFFFFFFF01000100FFFFFFFF01000100FFFF0100FFFF0000FFFFFFFF000000000100FFFF01000100FFFF010000000000FFFF0000010001000000FFFF0000FFFF01000100FFFF00000100FFFF000000000000FFFFFFFFFFFF0100FFFF00000000FFFF01000000FFFF0100FFFF00000100FFFFFFFFFFFF01000100FFFF0100FFFF010000000100FFFFFFFF0100FFFF0000FFFF00000100000000000100FFFFFFFF000000000100FFFF0000FFFF00000100FFFF0100FFFF01000100FFFF0100000001000000FFFF000000000100FFFF000001000100FFFFFFFFFFFF0000"> : tensor<20x20xi16>
    return %0 : tensor<20x20xi16>
  }
}
