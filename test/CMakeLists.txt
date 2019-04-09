enable_testing()
add_test(NAME test_hello
  COMMAND ${CMAKE_BINARY_DIR}/src/hello
  PASS_REGULAR_EXPRESSION "hello, world!"
  )
