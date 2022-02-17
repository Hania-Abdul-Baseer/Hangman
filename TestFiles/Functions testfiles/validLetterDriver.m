%driver script to test validLetter function

%test case 1
output = validLetter('1');
fprintf("Test case 1: expected: 0 got: %d\n", output);

%test case 2
output = validLetter('s');
fprintf("Test case 2: expected: 1 got: %d\n", output);

%test case 3
output = validLetter("f");
fprintf("Test case 3: expected: 1 got: %d\n", output);

%test case 4
output = validLetter('');
fprintf("Test case 4: expected: 0 got: %d\n", output);

%test case 5
output = validLetter(' ');
fprintf("Test case 5: expected: 0 got: %d\n", output);

%test case 6
output = validLetter('seal');
fprintf("Test case 6: expected: 0 got: %d\n", output);

%test case 7
output = validLetter('T');
fprintf("Test case 7: expected: 1 got: %d\n", output);

%test case 8
output = validLetter('tt');
fprintf("Test case 8: expected: 0 got: %d\n", output);

%test case 9
output = validLetter('?');
fprintf("Test case 9: expected: 0 got: %d\n", output);

%test case 10
output = validLetter('r r');
fprintf("Test case 10: expected: 0 got: %d\n", output);

%test case 11
output = validLetter('/');
fprintf("Test case 11: expected: 0 got: %d\n", output);

%test case 12
output = validLetter(';');
fprintf("Test case 12: expected: 0 got: %d\n", output);

%test case 13
output = validLetter("bye");
fprintf("Test case 13: expected: 0 got: %d\n", output);

