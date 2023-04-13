// RUN: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf32>
    %1 = call @expected() : () -> tensor<20x20xf32>
    %2 = stablehlo.log_plus_one %0 : tensor<20x20xf32>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xf32>, tensor<20x20xf32>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0x475DBBBF2EEB0C3F4CC269402F1BECBFD0E11FBE7A3875BF16596D40E7E7F0BF678F77C05F03E63E4B3235C033460DC02DAC35C0B0078240CF8F9DC083E2D9BFCFD5514066ABE53FFE25E0C003FD80C04A28B6BFB8E91B40BB30E83FE45906C0C2C8C4BE5AB8B840AF6750C0C9A17D40906D73404C1649BFBC953F3FED8237C06FD07BC0408D15C0C6331EC08D5AA4BFE831CC3F45B87E40852C48BF9AD0903F842040BF538A953F1069F23E009A80BE1A03403F40141E40E21EAF3D2942ABC052CC023E0CE816401F600BC05D94A1BF1B34AEC0CF105440517DA23D9CF54BC077520F40FDB1A640781901C16E045F3F7AF492BF1D643A404B9A9FC0DFC7C1400CB1F0BE3DD77D40DAF01A3FB8E2CC40A2282440606A60BF39983EC084D8873FCC2CD9BF7124DA40792FE43FFE1472405E75B9BF19D60640B430A1402AB00DC054FCA3BE1B8307C0D382B2BF9A764ABF1BBB35C0E083523FEA568BBF28FD1340D57637C0B5329CBFEA6FFCBF062F8AC02B3ED3BFD53191BFD25744C004035840E9940BC06F931640B0E75740212C8A3FED2BA83EFB76834094B0EE3FC361983FB5FE514057BC2C3E87E061BE510D1EBFAD1C05C063853E405917343F42A757C06E2E9ABEDA44E63E2B3BDE3F5658ED40EEFF79C0C53F1DC0F91B97BFD172623F5EA412BF3EF755C0C1B234C035AEA83F19007D40C95BE3C0D62E7240DC46F0BF869EEABF264E8A3FE67A473F1A6FAC3F227C2A3F19AEDABFC86CFF3F2EF60DC0D7DB34401EF22DC059C3163F1AA2C13E1127794078E965C0862F6F4087322ABF39611340333B8DC08659F2BF604FBB406911DAC0359B96C0CA9411C02060A9C0A191973FEC8C2EC062768F3FF8E42AC0DF1F94C047A0AF3F691B8640AA0527C09C4330BF27664CBF18510C401381973E35397DC0167B293FB49A55BF57FE123F3D8A14C0350C213FC666BD40AD5B534053DE17C0473BB84004B5DB3E52065E3F38808B3FCE0EF03F04A143C054514340282871C0B91E1040D6E523C060BB5540E61C0AC0EBDF9B404320903FC63AC0BEEA674BC0175B1CC053C0664040D85DC00A5A12BF1A5996BFAD508CBF77D2A1C05DE3044056433840D0E030BE26E36D40FAA488C01CC228C0499043BFB92EAEC050E18CC0580BC740AA4C3BBF6DEA66C0932806C085C51ABF99F715C0E9DA08BFBE9F38C08EBC014039C9DB3F0D91BC3F57BE9D40E2F99BC0D1422EBF8EC3FA3F691C02C06A220C4077E58C4070AF853FC9C3E63F10535BBFCCFD22C0CEF914400FB630C00F0F62C01DB245BE9E8AF63FF3FAC1BDC38AB3BE1AD4AF3F766E1FC0DC77833FF44AD03F66F11DBF91B4B6BEE8E61EBFDCEC9BC05FDE8BBF9C783A401B3468C0253BF7BF2BAE43C043543140F80553BE975D18C0B2AE59400A4BB8BE4BA5194012D2CDBF60282740FF2CC5BFE855BE3EBEAA4EC0292E70C0D33C86BE0FD988BF5A341E40D9B68B40E938E8C0769A19C0A8C08BBE73E149C0E62ED33FBFA4A140FDE1883F487A2ABE28D23E3FBFB1DDBE9439B940220F04C01F82A4C0BADDD0C071EB75C06E2C1241EE9182C04AA7B73F7EB90A409901AD3E20B0213FE9A952BE49842CC090186140AECE83403889FB3F66746E3E9706763F5C7863C03C53E5BFD8878A3F61A2A83F89E58A40841EB43D25BA24BF934181C0916CA8C0BC258B408275A9BF45BF8F3FA30015BF59ED30BF126A054098BE70C024E643BF190FC23FFBE1833F5D2E15BFF1E704BFA18F2ABF8E30933EE4EC0BBFFDAD7BC07353EFC0DEB2ECBE8FE9A6C0B7452740223866BF7FDCA94076F0624033298940110E4BBF3BFC1AC02D3BB6C0134D8DBFF1818740516EB5BF638883C07C7A8340BB432DC034A405404C4308C0532F3240267C4DBE420215BF42922A40284CDEBFCB1EB9BDA3BFA1BE69D52440F579813F9F0DA43F4CBF6FBF39938AC085D7D63F8FA3BB3FC310B93EE821CCBE78C3C43F16CB43BF873610C029DE074004E9513F989971C0733894BF01C286BCB24831C0D92BB2BF70EEDEBF2FA564402976C9C0FAAEBD3E120995BFF0E1EBBFDE7DD43F358F4A40DA661440DD7BAEC06BB7A140B330BABF881C48C01F98BA3F50A921400CC78F404A4923C0565484BE095FAB3F15989B3FE3543EC0EBA118C183871A40E626EDBE366F913E25BA88C06D1430BFF9EC9EBFF2A888400BB9D8BF184133C0E826A0BFE5A23EC064200F40C56A0F3F514C01C151CD87BF853A84C07794BE3F"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
  func.func private @expected() -> tensor<20x20xf32> {
    %0 = stablehlo.constant dense<"0xFFFFFFFF248AE03E90C9C43FFFFFFFFF3DD62DBE00B94AC02C52C63FFFFFFFFFFFFFFFFF45F9BD3EFFFFFFFFFFFFFFFFFFFFFFFF329FCF3FFFFFFFFFFFFFFFFFFD10BA3FB787833FFFFFFFFFFFFFFFFFFFFFFFFF24FF9D3FDA6D843FFFFFFFFFB95AF8BEF4D8F43FFFFFFFFFAC0ECD3FB7E0C83F030CC5BF3A060F3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2425743FB47ECD3F91EFC2BF3ABB413F31B3B1BFAC20463F1175C63E8F1894BEC0440F3F53409F3FE208A83DFFFFFFFF2530F63D860C9B3FFFFFFFFFFFFFFFFFFFFFFFFFD01ABB3F8A5D9C3DFFFFFFFF3473963F90BBE93FFFFFFFFF3066203FFFFFFFFF2B9CAE3FFFFFFFFF0D17FA3FD89322BF3524CD3FAE50F23E2C1E004052B5A23FB7EB05C0FFFFFFFF722C393FFFFFFFFF539A034077FF823FF050C83FFFFFFFFFC419913FE222E63FFFFFFFFF66ACC5BEFFFFFFFFFFFFFFFFB04BC8BFFFFFFFFF02A1193FFFFFFFFF9F4C993FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE2EBBC3FFFFFFFFF16DA9A3F64DFBC3FD06B3B3F226B913E12C0D03FDCB7863F3EBC483F1824BA3F4A9F1F3EB0307FBE1EF375BFFFFFFFFF3DB4B03F525D083FFFFFFFFFE272B7BE7026BE3E0FD7803F23560840FFFFFFFFFFFFFFFFFFFFFFFFF339223FB7BD59BFFFFFFFFFFFFFFFFF3B33573F73CDCC3FFFFFFFFFBE5BC83FFFFFFFFFFFFFFFFF878C3B3F2C80133F2C6B5A3F8AA9023FFFFFFFFF386E8C3FFFFFFFFF0DC0AB3FFFFFFFFF5615ED3E173CA43E473DCB3FFFFFFFFF6319C73F9DEB8BBF55EE983FFFFFFFFFFFFFFFFF3A5EF63FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDFD473FFFFFFFFF8A75403FFFFFFFFFFFFFFFFFD11F5D3F83CDD23FFFFFFFFF7B4E95BF7102CDBFB894943F3FB7843EFFFFFFFF110F023F2629E6BF0351E83EFFFFFFFF2ADEF93E3C95F73FB7C6BA3FFFFFFFFFFF8EF43F00D0B63E3FDE1F3F18B23C3FE231873FFFFFFFFF0818B33FFFFFFFFF11F1963FFFFFFFFFFFDFBB3FFFFFFFFFA690E23F8D15413F6202F1BEFFFFFFFFFFFFFFFFE47CC33FFFFFFFFFF30F59BFFFFFFFFFFFFFFFFFFFFFFFFF20D78F3F7D84AD3FA82D42BEC38CC63FFFFFFFFFFFFFFFFF6EC7B8BFFFFFFFFFFFFFFFFF320AFD3FB35FA8BFFFFFFFFFFFFFFFFF26846DBFFFFFFFFF5FCC43BFFFFFFFFF5EC68D3FFAE27F3F11CF673FFCD4E33FFFFFFFFF772192BF70DD8A3FFFFFFFFF7677943F30EED73F9B11373FE7EB833F6FB6F8BFFFFFFFFFD1E4993FFFFFFFFFFFFFFFFF30A85BBE186E893FA4CACBBD5C16DDBE7F4B5D3FFFFFFFFFFEE3343FA048773F30AA75BF77FBE1BE4C2E78BFFFFFFFFFFFFFFFFFA5A6AE3FFFFFFFFFFFFFFFFFFFFFFFFF44E4A93FCF4E6CBEFFFFFFFFCEAEBD3FFE74E4BE8DAB9C3FFFFFFFFF3A61A43FFFFFFFFF1DD6A13EFFFFFFFFFFFFFFFFA5AD9BBEFFFFFFFFD2529F3F620DD73FFFFFFFFFFFFFFFFF4735A3BEFFFFFFFF7E79793FAE6FE63F842D3A3F72783ABE45960E3F7D4011BF3025F53FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA13A1440FFFFFFFFF9CD633F5D94933F7F0B953E40A7FA3EE1DA6BBEFFFFFFFF1102C13FAC04D13F2B208B3F9C5D563ECA682C3FFFFFFFFFFFFFFFFFF7C33B3F0629573FFB70D63F65A2AC3D6B0284BFFFFFFFFFFFFFFFFF08A1D63FFFFFFFFF3CBA403FC3535FBF1A6096BF962E903FFFFFFFFFC67DB9BF5B366C3F9E4C353F42C15FBF62733BBFCC768CBF2660813E4E7B4ABFFFFFFFFFFFFFFFFF5ED61EBFFFFFFFFF7871A43F4BEA12C094C1EB3F57D2C13F7A22D53FD7B7C9BFFFFFFFFFFFFFFFFFFFFFFFFFA2E0D33FFFFFFFFFFFFFFFFFD1C2D03FFFFFFFFF4254903FFFFFFFFF4158AA3F055B65BEA4575FBF9741A63FFFFFFFFF2407C2BD8D64C2BE1C16A33FF6EA323F072D533F4E7130C0FFFFFFFFA0387C3FBD0E673FE2FA9D3E363702BF6A5A6E3F3444B9BFFFFFFFFF51C3913FF94B193FFFFFFFFFFFFFFFFFE6E087BCFFFFFFFFFFFFFFFFFFFFFFFFEB91C23FFFFFFFFF5E5CA13EFFFFFFFFFFFFFFFFD4757A3F909EB63F618C993FFFFFFFFF047CE63FFFFFFFFFFFFFFFFF7935663FAD4CA13FBD0BDA3FFFFFFFFF3D1999BEEE82593FC7A64B3FFFFFFFFFFFFFFFFF53309D3F5A421FBFAC02803EFFFFFFFFD30295BFFFFFFFFF49C1D43FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4554963F96C0E33EFFFFFFFFFFFFFFFFFFFFFFFF8F6E693F"> : tensor<20x20xf32>
    return %0 : tensor<20x20xf32>
  }
}
