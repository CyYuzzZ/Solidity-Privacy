add_custom_target(ossfuzz)
add_dependencies(ossfuzz
        solc_ossfuzz
        solc_mutator_ossfuzz
        const_opt_ossfuzz
        strictasm_diff_ossfuzz
        strictasm_opt_ossfuzz
        strictasm_assembly_ossfuzz
)

if (OSSFUZZ)
    add_custom_target(ossfuzz_proto)
    add_dependencies(ossfuzz_proto
            sol_proto_ossfuzz
            yul_proto_ossfuzz
            yul_proto_diff_ossfuzz
            yul_proto_diff_custom_mutate_ossfuzz
            stack_reuse_codegen_ossfuzz
    )

    add_custom_target(ossfuzz_abiv2)
    add_dependencies(ossfuzz_abiv2 abiv2_proto_ossfuzz abiv2_isabelle_ossfuzz)
endif()

if (OSSFUZZ)
    add_executable(solc_ossfuzz
            solc_ossfuzz.cpp
            ../fuzzer_common.cpp
            ../../TestCaseReader.cpp
    )
    target_link_libraries(solc_ossfuzz PRIVATE libsolc evmasm)
    set_target_properties(solc_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})

    add_executable(solc_mutator_ossfuzz
            solc_ossfuzz.cpp
            ../fuzzer_common.cpp
            ../../TestCaseReader.cpp
            SolidityGenerator.cpp
            SolidityCustomMutatorInterface.cpp
    )
    target_link_libraries(solc_mutator_ossfuzz PRIVATE libsolc evmasm)
    set_target_properties(solc_mutator_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})

    add_executable(const_opt_ossfuzz const_opt_ossfuzz.cpp ../fuzzer_common.cpp)
    target_link_libraries(const_opt_ossfuzz PRIVATE libsolc evmasm)
    set_target_properties(const_opt_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})

    add_executable(strictasm_diff_ossfuzz strictasm_diff_ossfuzz.cpp yulFuzzerCommon.cpp)
    target_link_libraries(strictasm_diff_ossfuzz PRIVATE libsolc evmasm yulInterpreter)
    set_target_properties(strictasm_diff_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})

    add_executable(strictasm_opt_ossfuzz strictasm_opt_ossfuzz.cpp)
    target_link_libraries(strictasm_opt_ossfuzz PRIVATE yul)
    set_target_properties(strictasm_opt_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})

    add_executable(strictasm_assembly_ossfuzz strictasm_assembly_ossfuzz.cpp)
    target_link_libraries(strictasm_assembly_ossfuzz PRIVATE yul)
    set_target_properties(strictasm_assembly_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})

    add_executable(yul_proto_ossfuzz
	    yulProtoFuzzer.cpp
	    protoToYul.cpp
	    yulProto.pb.cc
	    ../../libyul/YulOptimizerTestCommon.cpp
    )
    target_include_directories(yul_proto_ossfuzz PRIVATE /usr/include/libprotobuf-mutator)
    target_link_libraries(yul_proto_ossfuzz PRIVATE yul
            protobuf-mutator-libfuzzer.a
            protobuf-mutator.a
            protobuf.a
    )
    set_target_properties(yul_proto_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})
    target_compile_options(yul_proto_ossfuzz PUBLIC ${COMPILE_OPTIONS} -Wno-sign-conversion -Wno-suggest-destructor-override -Wno-inconsistent-missing-destructor-override)

    add_executable(
	    yul_proto_diff_ossfuzz
	    yulProto_diff_ossfuzz.cpp
	    yulFuzzerCommon.cpp
	    protoToYul.cpp
	    yulProto.pb.cc
	    ../../libyul/YulOptimizerTestCommon.cpp
    )
    target_include_directories(yul_proto_diff_ossfuzz PRIVATE /usr/include/libprotobuf-mutator)
    target_link_libraries(yul_proto_diff_ossfuzz PRIVATE yul
            yulInterpreter
            protobuf-mutator-libfuzzer.a
            protobuf-mutator.a
            protobuf.a
    )
    set_target_properties(yul_proto_diff_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})
    target_compile_options(yul_proto_diff_ossfuzz PUBLIC ${COMPILE_OPTIONS} -Wno-sign-conversion -Wno-suggest-destructor-override -Wno-inconsistent-missing-destructor-override)

    add_executable(yul_proto_diff_custom_mutate_ossfuzz
            yulProto_diff_ossfuzz.cpp
            yulFuzzerCommon.cpp
            protoToYul.cpp
            yulProto.pb.cc
            protomutators/YulProtoMutator.cpp
            ../../libyul/YulOptimizerTestCommon.cpp
    )
    target_include_directories(yul_proto_diff_custom_mutate_ossfuzz PRIVATE /usr/include/libprotobuf-mutator)
    target_link_libraries(yul_proto_diff_custom_mutate_ossfuzz PRIVATE yul
            yulInterpreter
            protobuf-mutator-libfuzzer.a
            protobuf-mutator.a
            protobuf.a
    )
    set_target_properties(yul_proto_diff_custom_mutate_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})
    target_compile_options(yul_proto_diff_custom_mutate_ossfuzz PUBLIC ${COMPILE_OPTIONS} -Wno-sign-conversion -Wno-suggest-destructor-override -Wno-inconsistent-missing-destructor-override)

    add_executable(stack_reuse_codegen_ossfuzz
            StackReuseCodegenFuzzer.cpp
            protoToYul.cpp
            yulProto.pb.cc
            ../../EVMHost.cpp
            YulEvmoneInterface.cpp
    )
    target_include_directories(stack_reuse_codegen_ossfuzz PRIVATE /usr/include/libprotobuf-mutator)
    target_link_libraries(stack_reuse_codegen_ossfuzz PRIVATE yul
            evmc
            evmone-standalone
            protobuf-mutator-libfuzzer.a
            protobuf-mutator.a
            protobuf.a
    )
    set_target_properties(stack_reuse_codegen_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})
    target_compile_options(stack_reuse_codegen_ossfuzz PUBLIC
            ${COMPILE_OPTIONS}
            -Wno-sign-conversion
            -Wno-inconsistent-missing-destructor-override
            -Wno-unused-parameter
            -Wno-zero-length-array
            -Wno-suggest-destructor-override
    )

    add_executable(abiv2_proto_ossfuzz
            ../../EVMHost.cpp
            abiV2ProtoFuzzer.cpp
            SolidityEvmoneInterface.cpp
            protoToAbiV2.cpp
            abiV2Proto.pb.cc
    )
    target_include_directories(abiv2_proto_ossfuzz PRIVATE
            /usr/include/libprotobuf-mutator
    )
    target_link_libraries(abiv2_proto_ossfuzz PRIVATE solidity
            evmc
            evmone-standalone
            protobuf-mutator-libfuzzer.a
            protobuf-mutator.a
            protobuf.a
    )
    set_target_properties(abiv2_proto_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})
    target_compile_options(abiv2_proto_ossfuzz PUBLIC ${COMPILE_OPTIONS} -Wno-sign-conversion -Wno-suggest-destructor-override -Wno-inconsistent-missing-destructor-override)

    add_executable(abiv2_isabelle_ossfuzz
            AbiV2IsabelleFuzzer.cpp
            SolidityEvmoneInterface.cpp
            ../../EVMHost.cpp
            protoToAbiV2.cpp
            abiV2Proto.pb.cc
    )
    target_include_directories(abiv2_isabelle_ossfuzz PRIVATE
            /usr/include/libprotobuf-mutator
    )
    target_link_libraries(abiv2_isabelle_ossfuzz PRIVATE solidity
            evmc
            evmone-standalone
            protobuf-mutator-libfuzzer.a
            protobuf-mutator.a
            protobuf.a
            abicoder
            gmp.a
    )
    set_target_properties(abiv2_isabelle_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})
    target_compile_options(abiv2_isabelle_ossfuzz PUBLIC ${COMPILE_OPTIONS} -Wno-sign-conversion -Wno-suggest-destructor-override -Wno-inconsistent-missing-destructor-override)

    add_executable(sol_proto_ossfuzz
            solProtoFuzzer.cpp
            SolidityEvmoneInterface.cpp
            protoToSol.cpp
            solProto.pb.cc
            ../../EVMHost.cpp
    )
    target_include_directories(sol_proto_ossfuzz PRIVATE
            /usr/include/libprotobuf-mutator
    )
    target_link_libraries(sol_proto_ossfuzz PRIVATE solidity libsolc
            evmc
            evmone-standalone
            protobuf-mutator-libfuzzer.a
            protobuf-mutator.a
            protobuf.a
    )
    set_target_properties(sol_proto_ossfuzz PROPERTIES LINK_FLAGS ${LIB_FUZZING_ENGINE})
    target_compile_options(sol_proto_ossfuzz PUBLIC ${COMPILE_OPTIONS} -Wno-sign-conversion -Wno-suggest-destructor-override -Wno-inconsistent-missing-destructor-override)
else()
    add_library(solc_ossfuzz
            solc_ossfuzz.cpp
            ../fuzzer_common.cpp
            )
    target_link_libraries(solc_ossfuzz PRIVATE libsolc evmasm)

    add_library(solc_mutator_ossfuzz
            solc_ossfuzz.cpp
            ../fuzzer_common.cpp
            )
    target_link_libraries(solc_mutator_ossfuzz PRIVATE libsolc evmasm)

    add_library(const_opt_ossfuzz
            const_opt_ossfuzz.cpp
            ../fuzzer_common.cpp)
    target_link_libraries(const_opt_ossfuzz PRIVATE libsolc evmasm)

    add_library(strictasm_diff_ossfuzz
            strictasm_diff_ossfuzz.cpp
            yulFuzzerCommon.cpp
            )
    target_link_libraries(strictasm_diff_ossfuzz PRIVATE libsolc evmasm yulInterpreter)

    add_library(strictasm_opt_ossfuzz
            strictasm_opt_ossfuzz.cpp
            )
    target_link_libraries(strictasm_opt_ossfuzz PRIVATE yul)

    add_library(strictasm_assembly_ossfuzz
            strictasm_assembly_ossfuzz.cpp
            )
    target_link_libraries(strictasm_assembly_ossfuzz PRIVATE yul)

#    add_executable(yul_proto_ossfuzz yulProtoFuzzer.cpp protoToYul.cpp yulProto.pb.cc)
#    target_include_directories(yul_proto_ossfuzz PRIVATE /src/libprotobuf-mutator /src/LPM/external.protobuf/include)
#    target_link_libraries(yul_proto_ossfuzz PRIVATE yul
#            protobuf-mutator-libfuzzer.a
#            protobuf-mutator.a
#            protobuf.a
#            FuzzingEngine.a)
#
#    add_executable(yul_proto_diff_ossfuzz yulProto_diff_ossfuzz.cpp yulFuzzerCommon.cpp protoToYul.cpp yulProto.pb.cc)
#    target_include_directories(yul_proto_diff_ossfuzz PRIVATE /src/libprotobuf-mutator /src/LPM/external.protobuf/include)
#    target_link_libraries(yul_proto_diff_ossfuzz PRIVATE yul
#            yulInterpreter
#            protobuf-mutator-libfuzzer.a
#            protobuf-mutator.a
#            protobuf.a
#            FuzzingEngine.a)
#    add_executable(abiv2_proto_ossfuzz
#            ../../EVMHost.cpp
#            abiV2ProtoFuzzer.cpp
#            abiV2FuzzerCommon.cpp
#            protoToAbiV2.cpp
#            abiV2Proto.pb.cc
#    )
#    target_include_directories(abiv2_proto_ossfuzz PRIVATE
#            /src/LPM/external.protobuf/include
#            /src/libprotobuf-mutator
#            /src/evmone/include
#    )
#    target_link_libraries(abiv2_proto_ossfuzz PRIVATE solidity
#            evmone intx ethash keccak evmc-instructions evmc
#            protobuf-mutator-libfuzzer.a
#            protobuf-mutator.a
#            protobuf.a
#            FuzzingEngine.a
#    )
endif()
