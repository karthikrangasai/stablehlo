// RUN-DISABLED:: stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt -inline | stablehlo-translate --interpret
// RUN: diff <(stablehlo-translate --deserialize %s.0_9_0.bc | stablehlo-opt) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-translate --serialize --target=current %s | stablehlo-translate --deserialize | stablehlo-opt) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<20x20xf16>
    %1 = call @expected() : () -> tensor<20x20xf16>
    %2 = stablehlo.exponential_minus_one %0 : tensor<20x20xf16>
    %3 = stablehlo.custom_call @check.eq(%2, %1) : (tensor<20x20xf16>, tensor<20x20xf16>) -> tensor<i1>
    return %3 : tensor<i1>
  }
  func.func private @inputs() -> tensor<20x20xf16> {
    %0 = stablehlo.constant dense<"0x09B14A3E3E450FB0C7B56DC452BC7E3F1CBEDCBF294155BD20BD364227C41840E636623F29BED940FEC1663FA5BF91C54DB0B8C518C02BC07FB53D3BFE4471C5173FEB40734032B94F44A748EFC343BD4242013E97388E41CC396C3CBD3F0DBE6BBF8C423C3578C094B7B8BF16BEA4BB60C091C007BC7C3B6F44B5C6E43F7BBFB4B70E265EBFC94429425035B93D3F44BAC1F8BD884337C2483B1F3EDB410BAE8839DEC0E5375DBE8C2E30C0C84284C13B45E2B540C2F73A15BDE5B257C4013D373EA8383F443345953C39433DB85E4466BE96BF95B451B0ECBF734737C08541DFC256B658343CC754C2EA3EABBE79C05BB172C2C83D5AB65DC5C4B79CBE91449645FE3FB33D1C3B44C2B9C1BDC08E3FD9C433C02240C73C83BE7A403C340B420D41E1C40445CFBC38C7E1C3473BAFB816C05EC18AC5EC33482D9E44D43EF440B0BBF6BA93C6D4C444B66BC1E944CD47B8BC16C0F4BA49C46BBFC6419A35BCBF93C25A340E4452C4233E1A3E7DC3D842494074412D4279C488B40F4442480638FCC193C2FB3D310EE9463F416B3853C0EC3A1F3ECFC0673E0942003904C21D3AAD3F96BBA8B5A53568AD6F424AB556C22BB9183CD9B817BF603A934473BF9743EB44873EBF3CA1BD7AC0063AFAC32E3E61BD20C3EBC507442DC0A6BBB13E41421DBC66B79341F7442BBD09C16E427BC32D3ED23D28C625C41BC2804128BE69C267205A3760BD923E4ABA63C48D477B45F6C083C3AC43B4416643AFBC0C423BC73B3AA1423B3A68C15FBA6839F043C73E6245374118B9DC3E923DEBC483C3413041C49CB85A45BFBF75430DBF34412FBBA8451CC34341A43BACC12F433F4065C0DCBEAFBAEEC38CC46141473FA9B57CC190383CBE8D438F3C9EC002B8AB32383A6DC1A1BF55C2C7393D42413BBBC4D5C3AD384FC506C9693C25C8E43A07B9633E4CB9094139406746A4AE3ABDB0BDF228A5BD98C69D40B844C3BFC746F84025340A411EBA8C3CE843D0C0CBBA20422C41CFC5A43C98C3B939A93BBB34FD3D33C89BBF0EB29B4472C44D38C2BC2BBC75C4F743F33466457A36DFB1D3363FB7A93C3CC384B3B7C0C5405C2F90B85DBDC141CABA813D5FC08FBE3FBE53BE75C34F48"> : tensor<20x20xf16>
    return %0 : tensor<20x20xf16>
  }
  func.func private @expected() -> tensor<20x20xf16> {
    %0 = stablehlo.constant dense<"0xA8B0A243E159A0AFDAB4E8BB48B9824543BAE1BA194AE4B9C8B9544DE0BBBE465038554549BA25499ABB5B45D1BAF8BB06B0F9BBF8BA01BBA6B4E23D9258F7BBE34459492048A4B795545E71D9BBDAB9764DF842323A8A4B423C0B40EC453DBAC0BA5A4E313625BB0AB6D7BA41BAECB81ABB2FBB14B9323E3455FDBB3146C4BA1DB62026BBBA6C57314D4E365C424D548BBB34BA4651A4BBF03D3E436C4CC5ADF83B4CBB1A395FBAE52E04BB2C4F7EBBCF59ECB4A6BB8E3DC1B934B2E5BBFD407643523A4D54A1594A40805094B6DD5462BACCBAF8B30AB0E5BAB66607BB664BBEBB3BB5FE34FFBBA9BBA2447DBA25BBEEB0AEBB7C423EB5F6BB27B678BAF355275C60465042BA3DA7BB8BBB40BB9C45F0BB05BBE5469A406EBA3048D934E14CBF49F0BBAE5898B9FEBBD8BBF03D18B7F6BA74BBF8BB7F34812D435683447349F0B8A6B8FDBBF0BB2FB578BB3558C4688AB9F6BAA5B8E4BBC0BA3C4CB536D8BAB4BB00351553E5BB46433243D0BB684F8647244B3C4DE9BBE4B31D53E06C3A3999BBB4BBEC42310ED363644AE63914BB803D3E4347BBEA43DC4CF23A9BBB963CD045E6B8C4B4C4362FADFD4D81B4AABB9EB7223F46B7A4BAE03CFF55C2BA6F513E581D448D400ABA26BB7E3CDABB6043EAB9C6BBFABBE45202BBECB85444734D24B9EDB59E4B7258CEB95BBBFA4DCFBB5E439242FCBBE0BB9FBB524B48BAADBB6B20AA38EAB92B445BB8E7BB6D67785B55BBD0BBAB51144CED5085B9E44CFFBBB83CA04EB83C77BB64B8BA3B7D527144C55A484A8AB78E440C42F1BBD0BB8C30E3BB02B7905AD9BA1451A0BA3E4ABEB8745CC5BB714A663E88BB6A505C471CBB90BA88B8D9BBEABBDD4A2B45C4B47CBB263A51BA5451404034BB4EB66933B43C78BBD0BAAABB3C3C684DE83DEEBBD7BB5A3AF6BB00BC0640FFBB783D78B7E043C0B7B3494247B5604EAED6B912BA0B290CBAFDBB8548F056DABAD9627F49BC34B64946B83C40635247BB94B8184D234AFABB6240D2BB2E3C6C3E8135F04200BCCEBA84B13056E8BBB23990B92EB9E8BB9552CD35E05AFD375DB14138D4B56940C9BBB3B23EBBEE48CC2FF4B6E8B9314C94B8EB411ABB72BA52BA5ABACFBB656D"> : tensor<20x20xf16>
    return %0 : tensor<20x20xf16>
  }
}
