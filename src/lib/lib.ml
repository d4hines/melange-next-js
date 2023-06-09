let message = "hello world"

let%expect_test "dummy test" =  
  print_endline message;
  [%expect {|hello world |}]
