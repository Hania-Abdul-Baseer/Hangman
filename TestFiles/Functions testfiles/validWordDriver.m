%driver script to test validWord function

%test case 1
output = validWord("bye");
fprintf("Test case 1: expected: 1 got: %d\n", output);

%test case 2
output = validWord("WrTds");
fprintf("Test case 2: expected: 1 got: %d\n", output);

%test case 3
output = validWord('bye');
fprintf("Test case 3: expected: 1 got: %d\n", output);

%test case 4
output = validWord("");
fprintf("Test case 4: expected: 0 got: %d\n", output);

%test case 5
output = validWord("2");
fprintf("Test case 5: expected: 0 got: %d\n", output);

%test case 6
output = validWord('4s');
fprintf("Test case 6: expected: 0 got: %d\n", output);

%test case 7
output = validWord(" ");
fprintf("Test case 7: expected: 0 got: %d\n", output);

%test case 8
output = validWord("sdgfc2");
fprintf("Test case 8: expected: 0 got: %d\n", output);

%test case 9
output = validWord("CLOUD");
fprintf("Test case 9: expected: 1 got: %d\n", output);

%test case 10
output = validWord('swim ');
fprintf("Test case 10: expected: 0 got: %d\n", output);

%test case 11
output = validWord("s2swimming2s");
fprintf("Test case 11: expected: 0 got: %d\n", output);

%test case 12
output = validWord("dodge?");
fprintf("Test case 12: expected: 0 got: %d\n", output);

%test case 13
output = validWord("/");
fprintf("Test case 14: expected: 0 got: %d\n", output);

%test case 14
output = validWord('j');
fprintf("Test case 4: expected: 0 got: %d\n", output);

%test case 15
output = validWord("J");
fprintf("Test case 15: expected: 0 got: %d\n", output);

%test case 16
output = validWord('HOUSE');
fprintf("Test case 16: expected: 1 got: %d\n", output);

